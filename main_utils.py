#!/usr/bin/env python
"""Main module for time-series photometry pipeline.

See Also
--------
read_spe : Module for reading SPE files.
utils : Utilities for time-series photometry.

Notes
-----
noinspection : Comments are created by PyCharm to flag permitted code inspection violations.
docstrings : This module's documentation follows the `numpy` doc example [1]_.
logger : stdout and stderr are managed by a logger [3]_.
STAGE : Major pipeline stages are flagged by the logger as `STAGE`. The associated value for each stage is separated
    by underscores.
TODO : Flag all to-do items with 'TODO:' in the code body (not the docstring) so that they are flagged when using
    an IDE.
'See Also' : Methods describe their relationships to each other within their docstrings under the 'See Also' section.
    All methods should be connected to at least one other method within this module [2]_.

References
----------
.. [1] https://github.com/numpy/numpy/blob/master/doc/example.py
.. [2] http://en.wikipedia.org/wiki/Pipeline_(software)
.. [3] https://docs.python.org/2/library/logging.html

"""
# TODO: Rename as main.py when 'calibrate' branch is merged with master.

# Forwards compatibility imports.
from __future__ import division, absolute_import, print_function

# Standard library imports.
import os
import time
import math
import json
import pickle
import logging
import argparse
import collections

# External package imports. Grouped procedurally then categorically.
import astropy
import ccdproc

# Internal package imports.
import utils


# noinspection PyShadowingNames
def main(fconfig, rereduce=False, verbose=False):
    """Time-series photometry pipeline.

    Parameters
    ----------
    fconfig : string
        Path to input configuration file as .json.
    rereduce : {False}, bool, optional
        Re-reduce all files. Overwrite previously reduced files. If false, use previously reduced files.
    verbose : {False}, bool, optional
        Print startup 'INFO:' messages to stdout.

    Returns
    -------
    None

    Notes
    -----
    Call as top-level script. Example usage:
        $ python main_utils.py --fconfig path/to/config.json -v

    """
    # TODO: write out fits files
    # Read configuration file.
    # Use binary read-write for cross-platform compatibility. Use Python-style indents in the JSON file.
    if verbose:
        print("INFO: Reading configuration file {fpath}".format(fpath=fconfig))
    with open(fconfig, 'rb') as fp:
        config_settings = json.load(fp, object_pairs_hook=collections.OrderedDict)
    if verbose:
        print("INFO: Configuration file settings: {settings}".format(settings=config_settings))
    # Check configuration file.
    if verbose:
        print("INFO: Checking configuration.")
    utils.check_reduce_config(dobj=config_settings)
    ################################################################################
    # Create logger.
    # Note: For root-level logger, use `getLogger()`, not `getLogger(__name__)`
    # http://stackoverflow.com/questions/17336680/python-logging-with-multiple-modules-does-not-work
    # TODO: make stdout from logger look like output to file.
    if verbose:
        print("INFO: stdout now controlled by logger.")
    logger = logging.getLogger()
    logger.setLevel(level=getattr(logging, config_settings['logging']['level'].upper()))
    fmt = '"%(asctime)s","%(name)s","%(levelname)s","%(message)s"'
    formatter = logging.Formatter(fmt=fmt)
    formatter.converter = time.gmtime
    flog = config_settings['logging']['filename']
    if flog is not None:
        fhandler = logging.FileHandler(filename=flog, mode='ab')
        fhandler.setFormatter(formatter)
        logger.addHandler(fhandler)
    logger.info("STAGE: BEGIN_LOG")
    logger.info("Log format: {fmt}".format(fmt=fmt.replace('\"', '\'')))
    logger.info("Log date format: default ISO 8601, UTC")
    logger.info("Configuration file settings: {settings}".format(settings=config_settings))
    ################################################################################
    # Create master calibration (calib.) frames.
    # TODO: parallelize
    logger.info("STAGE: MASTER_CALIBRATIONS")
    calib_fpath = config_settings['calib']
    master_fpath = config_settings['master']
    master_ccddata = {}
    # If not rereducing:
    if not rereduce:
        # If master calib. frame files already exists, read them.
        # Otherwise initialize master calib. frame as None.
        for imtype in master_fpath:
            mfpath = master_fpath[imtype]
            if (mfpath is not None) and os.path.isfile(mfpath):
                logger.info("Reading master {imtype} from: {fpath}".format(imtype=imtype, fpath=mfpath))
                with open(mfpath, 'rb') as fp:
                    master_ccddata[imtype] = pickle.load(fp)
            else:
                master_ccddata[imtype] = None
        # If calib. frames exist and if master calib. frames do not yet exist, create master calib. frames.
        # If master calib. frame file is specified, save master calib. frame to file.
        for imtype in master_fpath:
            cfpath = calib_fpath[imtype]
            mfpath = master_fpath[imtype]
            if (cfpath is not None) and os.path.isfile(cfpath) and (master_ccddata[imtype] is None):
                logger.info("Creating master {imtype} from: {fpath}".format(imtype=imtype, fpath=cfpath))
                dobj = utils.spe_to_dict(fpath=cfpath)
                master_ccddata[imtype] = utils.create_master_calib(dobj=dobj)
                if mfpath is not None:
                    logger.info("Writing master {imtype} to: {fpath}".format(imtype=imtype, fpath=mfpath))
                    with open(mfpath, 'wb') as fp:
                        pickle.dump(master_ccddata[imtype], fp)
    # If rereducing:
    else:
        # Recreate all master calib. frames.
        # If master calib. frame file is specified, save master calib. frame to file.
        for imtype in calib_fpath:
            cfpath = calib_fpath[imtype]
            mfpath = master_fpath[imtype]
            if (cfpath is not None) and os.path.isfile(cfpath):
                logger.info("Creating master {imtype} from: {fpath}".format(imtype=imtype, fpath=cfpath))
                dobj = utils.spe_to_dict(fpath=cfpath)
                master_ccddata[imtype] = utils.create_master_calib(dobj=dobj)
                if mfpath is not None:
                    logger.info("Writing master {imtype} to: {fpath}".format(imtype=imtype, fpath=mfpath))
                    with open(mfpath, 'wb') as fp:
                        pickle.dump(master_ccddata[imtype], fp)
    ################################################################################
    # Reduce object data and clean cosmic rays.
    logger.info("STAGE: REDUCE_DATA_AND_CLEAN_COSMIC_RAYS")
    rawfpath = config_settings['object']['raw']
    redfpath = config_settings['object']['reduced']
    # If not rereducing:
    if not rereduce:
        # If reduced and cleaned object file already exists, read it.
        if (redfpath is not None) and os.path.isfile(redfpath):
            logger.info("Reading reduced object data from: {fpath}".format(fpath=redfpath))
            with open(redfpath, 'rb') as fp:
                object_ccddata = pickle.load(fp)
        # Otherwise reduced object frames do not yet exist, so reduce and clean object frames with
        # all available master calib. frames.
        # If reduced object file is specified, save reduced and cleaned object frames to file.
        # `reduce_ccddata` handles cases where master calibration frames do not exist.
        else:
            logger.info("Reading raw object data from: {fpath}".format(fpath=rawfpath))
            object_ccddata = utils.spe_to_dict(rawfpath)
            dark_exptime = None
            if master_ccddata['dark'] is not None:
                dark_spe_footer_xml = master_ccddata['dark'].meta['footer_xml']
                dark_exptime = utils.get_exptime_prog(spe_footer_xml=dark_spe_footer_xml) * astropy.units.second
            flat_exptime = None
            if master_ccddata['flat'] is not None:
                flat_spe_footer_xml = master_ccddata['flat'].meta['footer_xml']
                flat_exptime = utils.get_exptime_prog(spe_footer_xml=flat_spe_footer_xml) * astropy.units.second
            object_spe_footer_xml = object_ccddata['footer_xml']
            object_exptime = utils.get_exptime_prog(spe_footer_xml=object_spe_footer_xml) * astropy.units.second
            exps = dict(dobj_exptime=object_exptime, dark_exptime=dark_exptime, flat_exptime=flat_exptime)
            logger.info("Exposure times: {exps}".format(exps=exps))
            logger.info("Reducing data.")
            object_ccddata = utils.reduce_ccddata(dobj=object_ccddata, dobj_exptime=object_exptime,
                                                  bias=master_ccddata['bias'],
                                                  dark=master_ccddata['dark'], dark_exptime=dark_exptime,
                                                  flat=master_ccddata['flat'], flat_exptime=flat_exptime)
            # TODO: Make a class to track progress.
            key_list = []
            for key in object_ccddata:
                if isinstance(object_ccddata[key], ccdproc.CCDData):
                    key_list.append(key)
            key_sortedlist = sorted(key_list)
            key_len = len(key_sortedlist)
            prog_interval = 0.05
            prog_divs = int(math.ceil(1.0 / prog_interval))
            key_progress = {}
            for idx in xrange(0, prog_divs + 1):
                progress = (idx / prog_divs)
                key_idx = int(math.ceil((key_len - 1) * progress))
                key = key_sortedlist[key_idx]
                key_progress[key] = progress
            logger.info("Cleaning cosmic rays.")
            for key in sorted(object_ccddata):
                if isinstance(object_ccddata[key], ccdproc.CCDData):
                    # TODO: give dict with readnoise, gain
                    # TODO: silence remove_cosmic_rays. directing stdout, stderr causes lacosmic to hang at end.
                    (object_ccddata[key].data, ray_mask) = utils.remove_cosmic_rays(object_ccddata[key].data)
                    if key in key_progress:
                        logger.info("Progress (%): {pct}".format(pct=int(key_progress[key] * 100)))
            if redfpath is not None:
                logger.info("Writing reduced object data to: {fpath}".format(fpath=redfpath))
                with open(redfpath, 'wb') as fp:
                    pickle.dump(object_ccddata, fp)
    # If rereducing:
    else:
        # Rereduce and clean all object frames.
        # If reduced object file is specified, save reduced and cleaned object frames to file.
        logger.info("Reading raw object data from: {fpath}".format(fpath=rawfpath))
        object_ccddata = utils.spe_to_dict(rawfpath)
        dark_exptime = None
        if master_ccddata['dark'] is not None:
            dark_spe_footer_xml = master_ccddata['dark'].meta['footer_xml']
            dark_exptime = utils.get_exptime_prog(spe_footer_xml=dark_spe_footer_xml) * astropy.units.second
        flat_exptime = None
        if master_ccddata['flat'] is not None:
            flat_spe_footer_xml = master_ccddata['flat'].meta['footer_xml']
            flat_exptime = utils.get_exptime_prog(spe_footer_xml=flat_spe_footer_xml) * astropy.units.second
        object_spe_footer_xml = object_ccddata['footer_xml']
        object_exptime = utils.get_exptime_prog(spe_footer_xml=object_spe_footer_xml) * astropy.units.second
        exps = dict(dobj_exptime=object_exptime, dark_exptime=dark_exptime, flat_exptime=flat_exptime)
        logger.info("Exposure times: {exps}".format(exps=exps))
        logger.info("Reducing data.")
        object_ccddata = utils.reduce_ccddata(dobj=object_ccddata, dobj_exptime=object_exptime,
                                              bias=master_ccddata['bias'],
                                              dark=master_ccddata['dark'], dark_exptime=dark_exptime,
                                              flat=master_ccddata['flat'], flat_exptime=flat_exptime)
        # TODO: Make a class to track progress.
        key_list = []
        for key in object_ccddata:
            if isinstance(object_ccddata[key], ccdproc.CCDData):
                key_list.append(key)
        key_sortedlist = sorted(key_list)
        key_len = len(key_sortedlist)
        prog_interval = 0.05
        prog_divs = int(math.ceil(1.0 / prog_interval))
        key_progress = {}
        for idx in xrange(0, prog_divs + 1):
            progress = (idx / prog_divs)
            key_idx = int(math.ceil((key_len - 1) * progress))
            key = key_sortedlist[key_idx]
            key_progress[key] = progress
        logger.info("Cleaning cosmic rays.")
        for key in sorted(object_ccddata):
            if isinstance(object_ccddata[key], ccdproc.CCDData):
                # TODO: give dict with readnoise, gain
                # TODO: silence remove_cosmic_rays. directing stdout, stderr causes lacosmic to hang at end.
                (object_ccddata[key].data, ray_mask) = utils.remove_cosmic_rays(object_ccddata[key].data)
                if key in key_progress:
                    logger.info("Progress (%): {pct}".format(pct=int(key_progress[key] * 100)))
        if redfpath is not None:
            logger.info("Writing reduced object data to: {fpath}".format(fpath=redfpath))
            with open(redfpath, 'wb') as fp:
                pickle.dump(object_ccddata, fp)
    # TODO: RESUME PIPELINE HERE
    # TODO: check programmed/actual exposure times since pulses could have been missed
    # TODO: check default experiments with footer metadata to confirm correct experiment settings for calib. frames
    # Clean up.
    if flog is not None:
        # noinspection PyUnboundLocalVariable
        logger.removeHandler(fhandler)
    return None


if __name__ == '__main__':
    defaults = {'fconfig': 'reduce_config.json'}
    parser = argparse.ArgumentParser(description="Read configuration file and reduce data.")
    parser.add_argument('--fconfig',
                        default=defaults['fconfig'],
                        help=(("Input JSON configuration file for data reduction.\n" +
                               "Default: {dflt}").format(dflt=defaults['fconfig'])))
    parser.add_argument('--rereduce',
                        action='store_true',
                        help=("Re-reduce all files. Overwrite previously reduced files.\n" +
                              "If option omitted, use previously reduced files."))
    parser.add_argument('--verbose', '-v',
                        action='store_true',
                        help="Print startup 'INFO:' messages to stdout.")
    args = parser.parse_args()
    if args.verbose:
        print("INFO: Arguments: {args}".format(args=args))
    if not os.path.isfile(args.fconfig):
        raise IOError("Configuration file does not exist: {fpath}".format(fpath=args.fconfig))
    (fbase, ext) = os.path.splitext(args.fconfig)
    if ext != '.json':
        raise IOError("Configuration file extension is not '.json': {fpath}".format(fpath=args.fconfig))
    main(fconfig=args.fconfig, rereduce=args.rereduce, verbose=args.verbose)
