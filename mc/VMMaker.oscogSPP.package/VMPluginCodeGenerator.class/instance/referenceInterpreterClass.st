C code generator
referenceInterpreterClass
	"Define the class from which to take methods to define the interpreter proxy imports."
	^(Smalltalk classNamed: #StackInterpreter) ifNil:
		[(Smalltalk classNamed: #Interpreter) ifNil:
			[InterpreterProxy]]