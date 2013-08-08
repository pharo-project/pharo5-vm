sources generation
generateCogSources
	" self generateCogSources "

	" generate sources for CoInterpreter"

	| top |
	CogRTLOpcodes initialize.
	CogIA32Compiler initialize.
	top := FileSystem workingDirectory parent.
	VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		to: (top / 'src') fullName
		platformDir: (top / 'platforms') fullName
		excluding:
			#(#BrokenPlugin #IA32ABIPluginSimulator #SlangTestPlugin #TestOSAPlugin #FFIPlugin #ReentrantARMFFIPlugin #ReentrantFFIPlugin #ReentrantPPCBEFFIPlugin #NewsqueakIA32ABIPlugin #NewsqueakIA32ABIPluginAttic)