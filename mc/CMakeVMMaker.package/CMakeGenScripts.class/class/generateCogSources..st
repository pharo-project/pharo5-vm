sources generation
generateCogSources: config
	" self generateCogSources "

	" generate sources for CoInterpreter"

	| top src |
	
	CogRTLOpcodes initialize.
	CogIA32Compiler initialize.
	
	top := config topDir.				
	src := config srcDir assureExistence fullName.
	
	VMMaker
		generate: CoInterpreter
		and: StackToRegisterMappingCogit
		to: src
		platformDir: ( top / 'platforms') fullName
		excluding:#(BrokenPlugin IA32ABIPluginSimulator SlangTestPlugin TestOSAPlugin
					FFIPlugin ReentrantARMFFIPlugin ReentrantFFIPlugin ReentrantPPCBEFFIPlugin NewsqueakIA32ABIPlugin
					 NewsqueakIA32ABIPluginAttic).
