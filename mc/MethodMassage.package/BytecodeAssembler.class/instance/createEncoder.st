instance initialization
createEncoder
	"The signFlag defines the bytecode set of a method.
	 So create a dummy method with its sign flag to that of
	 code's, and instantiate the dummy method's encoderClass."
	| dummyMethod |
	dummyMethod := CompiledMethod
						newMethod: 0
						header: (code signFlag ifTrue: [SmallInteger minVal] ifFalse: [0]).
	encoder := dummyMethod encoderClass new initScopeAndLiteralTables.
	encoder
		initClass: code methodClass
		literalStream: (self
						ensureLiteralsIncludeMethodClass: code literals
						isQuick: (self isQuickPrimitiveIndex: code primitive)).
	^encoder