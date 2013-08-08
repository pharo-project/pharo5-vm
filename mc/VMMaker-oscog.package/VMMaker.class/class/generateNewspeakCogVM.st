configurations
generateNewspeakCogVM
	^ VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(#NewspeakVM true #MULTIPLEBYTECODESETS true)
		to: 'oscogvm/nscogsrc' asFileReference fullName
		platformDir: 'oscogvm/platforms' asFileReference fullName
		including:
			#(#AsynchFilePlugin #BMPReadWriterPlugin #BalloonEnginePlugin #BitBltSimulation #DSAPlugin #DropPlugin #FileCopyPlugin #FilePlugin #FloatArrayPlugin #FloatMathPlugin #InflatePlugin #JPEGReadWriter2Plugin #JPEGReaderPlugin #LargeIntegersPlugin #Matrix2x3Plugin #MiscPrimitivePlugin #NewsqueakIA32ABIPlugin #RePlugin #SecurityPlugin #SocketPlugin #SoundPlugin #SqueakSSLPlugin #SurfacePlugin #ThreadedIA32FFIPlugin #UUIDPlugin #UnixOSProcessPlugin #VMProfileLinuxSupportPlugin #VMProfileMacSupportPlugin #Win32OSProcessPlugin)	"Cogit chooseCogitClass"