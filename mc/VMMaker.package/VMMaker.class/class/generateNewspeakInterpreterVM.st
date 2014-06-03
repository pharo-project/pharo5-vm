configurations
generateNewspeakInterpreterVM
	^VMMaker
		generate: NewspeakInterpreter
		to: (FileDirectory default pathFromURI: self sourceTree, '/nssrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#(	AsynchFilePlugin BMPReadWriterPlugin BalloonEnginePlugin BitBltSimulation DeflatePlugin DSAPlugin DropPlugin
					FileCopyPlugin FilePlugin FloatArrayPlugin FloatMathPlugin ImmX11Plugin JPEGReadWriter2Plugin
					JPEGReaderPlugin LargeIntegersPlugin Matrix2x3Plugin MiscPrimitivePlugin NewsqueakIA32ABIPlugin
					RePlugin SecurityPlugin SocketPlugin SoundPlugin SqueakSSLPlugin SurfacePlugin
					UUIDPlugin UnixOSProcessPlugin VMProfileLinuxSupportPlugin VMProfileMacSupportPlugin Win32OSProcessPlugin)