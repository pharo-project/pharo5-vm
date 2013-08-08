as yet unclassified
generateCogMacOS
	" generate sources for Stack Interpreter of Mac OS"

	| top |
	top := FileSystem workingDirectory parent.
	VMMaker
		generate: CoInterpreter
		to: (top / 'src') fullName
		platformDir: (top / 'platforms') fullName
		excluding:
			#(#BrokenPlugin #IA32ABIPluginSimulator #SlangTestPlugin #TestOSAPlugin #FFIPlugin #ReentrantARMFFIPlugin #ReentrantFFIPlugin #ReentrantPPCBEFFIPlugin).
	CogMacOSConfig generate