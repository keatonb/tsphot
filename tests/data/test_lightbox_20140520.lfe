﻿<?xml version="1.0" encoding="utf-8"?>
<ExperimentSession
  version="1" xmlns="http://www.princetoninstruments.com/lightfield/experiment/2009">
  <Experiment xmlns="http://www.princetoninstruments.com/experiment/2009"
    version="6" xmlns:r="http://www.princetoninstruments.com/experiment/restore/2009"
    r:version="1">
    <System>
      <Cameras
        count="1">
        <Camera
          deviceID="1"
          model="ProEM: 1024B"
          serialNumber="1912110009"
          computerInterface="Gigabit Ethernet"
          demo="False" />
      </Cameras>
      <LightSources
        count="1">
        <LightSource
          deviceID="2"
          model="LightSource" />
      </LightSources>
      <DeviceLinks
        count="1">
        <DeviceLink
          firstDeviceID="1"
          firstDeviceLinkNode="Input"
          secondDeviceID="2"
          secondDeviceLinkNode="Output" />
      </DeviceLinks>
    </System>
    <Devices>
      <Cameras
        count="1">
        <Camera
          deviceID="1">
          <Sensor>
            <Layout>
              <ActiveArea>
                <Width
                  r:priority="1"
                  type="Int32">1024</Width>
                <Height
                  r:priority="1"
                  type="Int32">1024</Height>
                <TopMargin
                  type="Int32">2</TopMargin>
                <LeftMargin
                  type="Int32">32</LeftMargin>
                <BottomMargin
                  type="Int32">6</BottomMargin>
                <RightMargin
                  type="Int32">16</RightMargin>
              </ActiveArea>
              <MaskedArea>
                <Height
                  type="Int32">1024</Height>
                <TopMargin
                  type="Int32">7</TopMargin>
                <BottomMargin
                  type="Int32">6</BottomMargin>
              </MaskedArea>
            </Layout>
            <Information>
              <SensorName
                r:readOnly="True"
                type="String">E2V 1024 x 1024 (CCD 201)(B)</SensorName>
              <CcdCharacteristics
                r:readOnly="True"
                type="CcdCharacteristics">BackIlluminated</CcdCharacteristics>
              <Type
                r:readOnly="True"
                type="SensorType">Ccd</Type>
              <ActiveArea>
                <Height
                  r:readOnly="True"
                  type="Int32">1024</Height>
                <Width
                  r:readOnly="True"
                  type="Int32">1024</Width>
                <BottomMargin
                  r:readOnly="True"
                  type="Int32">6</BottomMargin>
                <LeftMargin
                  r:readOnly="True"
                  type="Int32">32</LeftMargin>
                <RightMargin
                  r:readOnly="True"
                  type="Int32">16</RightMargin>
                <TopMargin
                  r:readOnly="True"
                  type="Int32">2</TopMargin>
              </ActiveArea>
              <MaskedArea>
                <BottomMargin
                  r:readOnly="True"
                  type="Int32">6</BottomMargin>
                <Height
                  r:readOnly="True"
                  type="Int32">1024</Height>
                <TopMargin
                  r:readOnly="True"
                  type="Int32">7</TopMargin>
              </MaskedArea>
              <Pixel>
                <Width
                  r:readOnly="True"
                  type="Double">13</Width>
                <Height
                  r:readOnly="True"
                  type="Double">13</Height>
                <GapWidth
                  r:readOnly="True"
                  type="Double">0</GapWidth>
                <GapHeight
                  r:readOnly="True"
                  type="Double">0</GapHeight>
              </Pixel>
              <Secondary>
                <ActiveArea>
                  <Height
                    r:readOnly="True"
                    type="Int32">0</Height>
                </ActiveArea>
                <MaskedArea>
                  <Height
                    r:readOnly="True"
                    type="Int32">0</Height>
                </MaskedArea>
              </Secondary>
            </Information>
            <Temperature>
              <SetPoint
                type="Double">-55</SetPoint>
              <Reading
                r:readOnly="True"
                type="Double">-55</Reading>
              <Status
                r:readOnly="True"
                type="SensorTemperatureStatus">Locked</Status>
              <DisableCoolingFan
                type="Boolean">False</DisableCoolingFan>
            </Temperature>
            <Cleaning>
              <FinalSectionHeight
                type="Int32">1024</FinalSectionHeight>
              <FinalSectionCount
                type="Int32">1</FinalSectionCount>
              <CleanSerialRegister
                relevance="False"
                type="Boolean">True</CleanSerialRegister>
              <CleanUntilTrigger
                type="Boolean">True</CleanUntilTrigger>
              <CycleCount
                type="Int32">1</CycleCount>
              <CycleHeight
                type="Int32">1024</CycleHeight>
              <CleanBeforeExposure
                relevance="False"
                type="Boolean">True</CleanBeforeExposure>
            </Cleaning>
          </Sensor>
          <ShutterTiming>
            <ExposureTime
              type="Double">9998</ExposureTime>
            <DelayResolution
              r:readOnly="True"
              type="Double">1000</DelayResolution>
            <OpeningDelay
              type="Double">0</OpeningDelay>
            <Mode
              type="ShutterTimingMode">AlwaysOpen</Mode>
            <ClosingDelay
              type="Double">0</ClosingDelay>
          </ShutterTiming>
          <ReadoutControl>
            <Mode
              r:priority="2"
              type="ReadoutControlMode">FrameTransfer</Mode>
            <Time
              r:readOnly="True"
              type="Double">142.70230000000004</Time>
            <Orientation
              r:readOnly="True"
              type="ReadoutOrientation">Normal</Orientation>
            <StorageShiftRate
              r:priority="5"
              type="Double">1.2</StorageShiftRate>
            <VerticalShiftRate
              relevance="False"
              r:priority="5"
              type="Double">1.2</VerticalShiftRate>
            <RegionsOfInterest>
              <Selection
                r:priority="2"
                type="RegionsOfInterestSelection">CustomRegions</Selection>
              <BinningProvider
                r:priority="2"
                type="FeatureProvider">Hardware</BinningProvider>
              <CustomRegions
                r:priority="5"
                count="1"
                type="RegionOfInterestCollection">
                <RegionOfInterest
                  id="0"
                  x="428"
                  width="162"
                  xBinning="1"
                  y="395"
                  height="127"
                  yBinning="1" />
              </CustomRegions>
              <BinnedSensor>
                <XBinning
                  relevance="False"
                  r:priority="3"
                  type="Int32">1</XBinning>
                <YBinning
                  relevance="False"
                  r:priority="3"
                  type="Int32">1</YBinning>
              </BinnedSensor>
              <LineSensor>
                <RowBinning
                  relevance="False"
                  r:priority="3"
                  type="Int32">1</RowBinning>
              </LineSensor>
              <Result
                r:readOnly="True"
                type="RegionOfInterestCollection"
                count="1">
                <RegionOfInterest
                  id="0"
                  x="428"
                  width="162"
                  xBinning="1"
                  y="395"
                  height="127"
                  yBinning="1" />
              </Result>
            </RegionsOfInterest>
            <Kinetics>
              <WindowHeight
                relevance="False"
                r:priority="1"
                type="Int32">10</WindowHeight>
            </Kinetics>
          </ReadoutControl>
          <HardwareIO>
            <OutputSignal
              type="OutputSignal">Exposing</OutputSignal>
            <TriggerDetermination
              type="TriggerDetermination">RisingEdge</TriggerDetermination>
            <TriggerResponse
              type="TriggerResponse">ReadoutPerTrigger</TriggerResponse>
            <InvertOutputSignal
              type="Boolean">False</InvertOutputSignal>
          </HardwareIO>
          <Adc>
            <Speed
              type="Double">1</Speed>
            <BitDepth
              r:readOnly="True"
              type="Int32">16</BitDepth>
            <AnalogGain
              type="AdcGain">Low</AnalogGain>
            <EMGain
              relevance="False"
              type="Int32">1</EMGain>
            <Quality
              r:priority="2"
              type="AdcQuality">LowNoise</Quality>
            <CorrectPixelBias
              type="Boolean">True</CorrectPixelBias>
          </Adc>
          <Acquisition>
            <Orientation
              r:readOnly="True"
              type="ReadoutOrientation">Normal</Orientation>
            <NormalizeOrientation
              relevance="False"
              r:priority="3"
              type="Boolean">True</NormalizeOrientation>
            <PixelFormat
              r:readOnly="True"
              type="PixelFormat">MonochromeUnsigned16</PixelFormat>
            <FrameSize
              r:readOnly="True"
              type="Int32">41148</FrameSize>
            <FrameStride
              r:readOnly="True"
              type="Int32">41172</FrameStride>
            <FramesPerReadout
              r:readOnly="True"
              type="Int32">1</FramesPerReadout>
            <ReadoutStride
              r:readOnly="True"
              type="Int32">41996</ReadoutStride>
            <PixelDepth
              r:readOnly="True"
              type="Int32">16</PixelDepth>
            <ReadoutRate
              r:readOnly="True"
              type="Double">0.10000761658007874</ReadoutRate>
            <FrameRate
              r:readOnly="True"
              type="Double">0.10000761658007874</FrameRate>
            <FrameTracking>
              <BitDepth
                r:readOnly="True"
                type="Int32">64</BitDepth>
              <Enabled
                type="Boolean">True</Enabled>
            </FrameTracking>
            <TimeStamping>
              <BitDepth
                r:readOnly="True"
                type="Int32">64</BitDepth>
              <Resolution
                r:readOnly="True"
                type="Int64">1000000</Resolution>
              <Stamps
                type="TimeStamps">ExposureStarted, ExposureEnded</Stamps>
            </TimeStamping>
          </Acquisition>
          <Experiment>
            <Acquisition>
              <FramesToStore
                type="Int64">9999</FramesToStore>
              <FrameSize
                r:readOnly="True"
                type="Int32">41148</FrameSize>
              <FrameStride
                r:readOnly="True"
                type="Int32">41172</FrameStride>
              <PixelDepth
                r:readOnly="True"
                type="Int32">16</PixelDepth>
              <PixelFormat
                r:readOnly="True"
                type="PixelDataFormat">MonochromeUnsigned16</PixelFormat>
              <Orientation>
                <Result
                  r:readOnly="True"
                  type="ImageOrientation">Normal</Result>
              </Orientation>
              <OutputFiles>
                <Result
                  r:readOnly="True"
                  type="String">D:\sync_to_White_Dwarf_Archive\instrument_testing\20140511_test_LightField_online_analysis\test_lightbox 2014-05-20 21_56_08.spe</Result>
              </OutputFiles>
            </Acquisition>
            <FileNameGeneration>
              <Directory
                r:priority="4"
                type="String">D:\sync_to_White_Dwarf_Archive\instrument_testing\20140511_test_LightField_online_analysis</Directory>
              <BaseFileName
                r:priority="4"
                type="String">test_lightbox</BaseFileName>
              <AttachTime
                r:priority="4"
                type="Boolean">True</AttachTime>
              <AttachDate
                r:priority="4"
                type="Boolean">True</AttachDate>
              <FileFormatLocation
                r:priority="3"
                type="FileFormatLocation">Suffix</FileFormatLocation>
              <AttachIncrement
                r:priority="4"
                type="Boolean">False</AttachIncrement>
              <TimeFormat
                r:priority="5"
                type="TimeFormat">hh_mm_ss_24hr</TimeFormat>
              <DateFormat
                r:priority="5"
                type="DateFormat">yyyy_mm_dd</DateFormat>
              <IncrementNumber
                relevance="False"
                r:priority="5"
                type="Int32">3</IncrementNumber>
              <IncrementMinimumDigits
                relevance="False"
                r:priority="5"
                type="Int32">1</IncrementMinimumDigits>
              <SaveRawData
                relevance="False"
                r:priority="1"
                type="Boolean">True</SaveRawData>
            </FileNameGeneration>
            <OnlineProcessing>
              <FrameCombination>
                <FramesCombined
                  r:priority="2"
                  type="Int64">1</FramesCombined>
                <Method
                  relevance="False"
                  r:priority="3"
                  type="FrameCombinationMethod">Average</Method>
              </FrameCombination>
            </OnlineProcessing>
            <OnlineCorrections>
              <OrientationCorrection>
                <Enabled
                  r:priority="1"
                  type="Boolean">False</Enabled>
                <FlipHorizontally
                  relevance="False"
                  r:priority="2"
                  type="Boolean">False</FlipHorizontally>
                <FlipVertically
                  relevance="False"
                  r:priority="2"
                  type="Boolean">False</FlipVertically>
                <RotateClockwise
                  relevance="False"
                  r:priority="2"
                  type="Int32">0</RotateClockwise>
              </OrientationCorrection>
              <BlemishCorrection>
                <Enabled
                  r:priority="3"
                  type="Boolean">False</Enabled>
                <DefinitionFile
                  relevance="False"
                  r:priority="4"
                  type="String">D:\sync_to_White_Dwarf_Archive\instrument_testing\20140419_dark_test\dark_test_LightField\Correction Files\BlemishCorrection.CSV</DefinitionFile>
              </BlemishCorrection>
              <BackgroundCorrection>
                <Enabled
                  r:priority="3"
                  type="Boolean">False</Enabled>
                <ReferenceFile
                  relevance="False"
                  r:priority="4"
                  type="String">D:\sync_to_White_Dwarf_Archive\instrument_testing\20140419_dark_test\dark_test_LightField\Correction Files\BackgroundReference.spe</ReferenceFile>
              </BackgroundCorrection>
              <FlatfieldCorrection>
                <Enabled
                  r:priority="3"
                  type="Boolean">False</Enabled>
                <ReferenceFile
                  relevance="False"
                  r:priority="4"
                  type="String">D:\sync_to_White_Dwarf_Archive\instrument_testing\20140419_dark_test\dark_test_LightField\Correction Files\FlatfieldReference.spe</ReferenceFile>
              </FlatfieldCorrection>
              <CosmicRayCorrection>
                <Enabled
                  r:priority="3"
                  type="Boolean">False</Enabled>
                <Method
                  relevance="False"
                  r:priority="4"
                  type="CosmicRayCorrectionMethod">MedianFilter</Method>
                <KernelSize
                  relevance="False"
                  r:priority="5"
                  type="Int32">5</KernelSize>
              </CosmicRayCorrection>
            </OnlineCorrections>
          </Experiment>
        </Camera>
      </Cameras>
    </Devices>
    <Environment>
      <WorkingDirectory
        type="String">D:\sync_to_White_Dwarf_Archive\instrument_testing\20140511_test_LightField_online_analysis</WorkingDirectory>
      <ScratchDirectory
        type="String">D:\sync_to_White_Dwarf_Archive\instrument_testing\20140511_test_LightField_online_analysis</ScratchDirectory>
    </Environment>
  </Experiment>
  <ItemPositions>
    <Item
      model="ProEM: 1024B"
      serialNumber="1912110009">0,0</Item>
    <Item
      model="Light Source"
      serialNumber="">1,0</Item>
  </ItemPositions>
</ExperimentSession>