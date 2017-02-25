utilities
openCogSpurMultiWindowBrowser
	"Answer a new multi-window browser on the ObjectMemory classes, the Cog Interpreter classes, and the main JIT classes"
	| b |
	b := Browser open.
	#(	SpurMemoryManager Spur32BitMemoryManager Spur32BitCoMemoryManager
		 Spur64BitMemoryManager Spur64BitCoMemoryManager SpurGenerationScavenger
		InterpreterPrimitives StackInterpreter StackInterpreterPrimitives CoInterpreter CoInterpreterPrimitives CoInterpreterMT
		Cogit SimpleStackBasedCogit StackToRegisterMappingCogit
		CogObjectRepresentation CogObjectRepresentationForSpur
		CogObjectRepresentationFor32BitSpur CogObjectRepresentationFor64BitSpur
		VMStructType VMMaker CCodeGenerator TMethod)
		do: [:className|
			(Smalltalk classNamed: className) ifNotNil:
				[:class| b selectCategoryForClass: class; selectClass: class]]
		separatedBy:
			[b multiWindowState addNewWindow].
	b multiWindowState selectWindowIndex: 1