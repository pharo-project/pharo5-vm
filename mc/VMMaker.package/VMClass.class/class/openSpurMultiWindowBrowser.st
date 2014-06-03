utilities
openSpurMultiWindowBrowser
	"Answer a new multi-window browser on the Spur classes, the Cog StackInterpreter classes, and the support classes"
	| b |
	b := Browser open.
	#(	SpurMemoryManager Spur32BitMemoryManager Spur64BitMemoryManager
		SpurGenerationScavenger SpurSegmentManager
		Spur32BitMMLESimulator SpurGenerationScavengerSimulator
		InterpreterPrimitives StackInterpreter StackInterpreterPrimitives
		VMStructType VMMaker CCodeGenerator TMethod)
		do: [:className|
			(Smalltalk classNamed: className) ifNotNil:
				[:class| b selectCategoryForClass: class; selectClass: class]]
		separatedBy:
			[b multiWindowState addNewWindow].
	b multiWindowState selectWindowIndex: 1