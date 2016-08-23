configurations
generateSqueakStackVM
	"RISC OS version; build needed plugins, make sure filename tweaking is used"
"RiscOSVMMaker generateSqueakStackVM"
	^self
		generate: StackInterpreter
		to: (FileDirectory default directoryNamed: 'stacksrc') fullName
		platformDir: (FileDirectory default directoryNamed: 'platforms') fullName
		excluding: #(AsynchFilePlugin BrokenPlugin CroquetPlugin FFIPlugin IA32ABIPlugin ImmX11Plugin InternetConfigPlugin JoystickTabletPlugin MIDIPlugin MacMenubarPlugin Mpeg3Plugin NewsqueakIA32ABIPlugin QuicktimePlugin SerialPlugin  TestOSAPlugin ThreadedARMFFIPlugin ThreadedFFIPlugin ThreadedIA32FFIPlugin ThreadedPPCBEFFIPlugin UUIDPlugin VMProfileMacSupportPlugin)