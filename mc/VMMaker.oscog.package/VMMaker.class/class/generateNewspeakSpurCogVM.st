configurations
generateNewspeakSpurCogVM
	"No primitives since we can use those for the Cog Newspeak VM"
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(	ObjectMemory Spur32BitCoMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				ISA IA32)
		to: (FileDirectory default pathFromURI: self sourceTree, '/nsspursrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#(	AsynchFilePlugin BMPReadWriterPlugin BalloonEnginePlugin BitBltSimulation
					DeflatePlugin DSAPlugin DropPlugin FileCopyPlugin FilePlugin FloatArrayPlugin FloatMathPlugin
					ImmX11Plugin JPEGReadWriter2Plugin JPEGReaderPlugin LargeIntegersPlugin
					Matrix2x3Plugin MiscPrimitivePlugin NewsqueakIA32ABIPlugin RePlugin
					SecurityPlugin SocketPlugin SoundPlugin SqueakSSLPlugin SurfacePlugin
					UUIDPlugin UnixOSProcessPlugin UnixAioPlugin
					VMProfileLinuxSupportPlugin VMProfileMacSupportPlugin Win32OSProcessPlugin)
