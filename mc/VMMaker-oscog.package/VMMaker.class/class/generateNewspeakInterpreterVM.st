configurations
generateNewspeakInterpreterVM
	^ VMMaker
		generate: NewspeakInterpreter
		to: 'oscogvm/nssrc' asFileReference fullName
		platformDir: 'oscogvm/platforms' asFileReference fullName
		including:
			#(#AsynchFilePlugin #BMPReadWriterPlugin #BalloonEnginePlugin #BitBltSimulation #DSAPlugin #DropPlugin #FileCopyPlugin #FilePlugin #FloatArrayPlugin #FloatMathPlugin #InflatePlugin #JPEGReadWriter2Plugin #JPEGReaderPlugin #LargeIntegersPlugin #Matrix2x3Plugin #MiscPrimitivePlugin #NewsqueakIA32ABIPlugin #RePlugin #SecurityPlugin #SocketPlugin #SoundPlugin #SqueakSSLPlugin #SurfacePlugin #UUIDPlugin #UnixOSProcessPlugin #VMProfileLinuxSupportPlugin #VMProfileMacSupportPlugin #Win32OSProcessPlugin)