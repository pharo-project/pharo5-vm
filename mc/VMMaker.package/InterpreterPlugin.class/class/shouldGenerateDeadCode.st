translation
shouldGenerateDeadCode
	"Answer if the code generator should generate dead code, e.g. in false ifTrue: [dead] ifFalse: [live].
	 Since plugin source is shared between different VM builds it is unsafe to assume any code is dead."

	^true