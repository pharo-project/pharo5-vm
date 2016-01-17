configurations
generateNewspeakSpurCogVM
	"This tree also includes the Newspeak plugins.  But once the Alien plugins are harmonised
	 (which can be done now immutability support is being added to Spur) all VMs can share a
	 single set of plugin sources."
	^VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		with: #(	ObjectMemory Spur32BitCoMemoryManager
				MULTIPLEBYTECODESETS true
				NewspeakVM true
				EnforceAccessControl true)
		to: (FileDirectory default pathFromURI: self sourceTree, '/nsspursrc')
		platformDir: (FileDirectory default pathFromURI: self sourceTree, '/platforms')
		including:#(	AsynchFilePlugin BMPReadWriterPlugin BalloonEnginePlugin BitBltSimulation
					DeflatePlugin DSAPlugin DropPlugin FileCopyPlugin FilePlugin FloatArrayPlugin FloatMathPlugin
					ImmX11Plugin JPEGReadWriter2Plugin JPEGReaderPlugin LargeIntegersPlugin
					Matrix2x3Plugin MiscPrimitivePlugin NewsqueakIA32ABIPlugin RePlugin
					SecurityPlugin SocketPlugin SoundPlugin SqueakSSLPlugin SurfacePlugin
					UUIDPlugin UnixOSProcessPlugin UnixAioPlugin
					VMProfileLinuxSupportPlugin VMProfileMacSupportPlugin Win32OSProcessPlugin)
