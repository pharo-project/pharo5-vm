source generation
generateStackSources
	" generate sources for Stack Interpreter"

	StackInterpreter initialize.
	
	VMMaker
		generate: StackInterpreter
		to: self srcDir fullName
		platformDir: self platformsDir fullName
		excluding: #(BrokenPlugin IA32ABIPluginSimulator SlangTestPlugin TestOSAPlugin
			FFIPlugin ReentrantARMFFIPlugin ReentrantFFIPlugin ReentrantPPCBEFFIPlugin).