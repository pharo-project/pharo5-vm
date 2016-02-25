configurations
generateVMPlugins
	^VMMaker
		generatePluginsTo: (FileDirectory default pathFromURI: self sourceTree, '/src')
		options: #()
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#(	ADPCMCodecPlugin AsynchFilePlugin
					BalloonEnginePlugin B3DAcceleratorPlugin B3DEnginePlugin BMPReadWriterPlugin BitBltSimulation
					BochsIA32Plugin BochsX64Plugin
					CameraPlugin CroquetPlugin DSAPlugin DeflatePlugin DropPlugin
					"FT2Plugin" FFTPlugin FileCopyPlugin FilePlugin FloatArrayPlugin FloatMathPlugin
					GeniePlugin GdbARMPlugin HostWindowPlugin IA32ABIPlugin ImmX11Plugin InternetConfigPlugin
					JPEGReadWriter2Plugin JPEGReaderPlugin JoystickTabletPlugin KlattSynthesizerPlugin
					LargeIntegersPlugin LocalePlugin MIDIPlugin MacMenubarPlugin Matrix2x3Plugin
					MiscPrimitivePlugin Mpeg3Plugin QuicktimePlugin RePlugin
					ScratchPlugin SecurityPlugin SerialPlugin SocketPlugin
					SoundCodecPlugin SoundGenerationPlugin SoundPlugin SqueakSSLPlugin StarSqueakPlugin
					ThreadedFFIPlugin ThreadedARMFFIPlugin ThreadedIA32FFIPlugin ThreadedX64SysVFFIPlugin ThreadedX64Win64FFIPlugin
					UnicodePlugin UnixAioPlugin UUIDPlugin UnixOSProcessPlugin
					Win32OSProcessPlugin VMProfileLinuxSupportPlugin VMProfileMacSupportPlugin WeDoPlugin
					XDisplayControlPlugin)