utilities
defaultTestClass
	"self defaultTestClass"
	| defaultInstructionCompilerClass |
	defaultInstructionCompilerClass := (Cogit classPool at: #ProcessorClass) new abstractInstructionCompilerClass.
	^self subclasses detect: [:sc| sc new concreteCompilerClass inheritsFrom: defaultInstructionCompilerClass]