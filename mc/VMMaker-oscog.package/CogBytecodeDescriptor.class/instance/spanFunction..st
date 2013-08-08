accessing
spanFunction: functionPointer
	"Set the value of spanFunction"
	<returnTypeC: 'sqInt (*)(BytecodeDescriptor *,sqInt,sqInt,sqInt)'>
	<var: #functionPointer declareC: 'sqInt (*functionPointer)(BytecodeDescriptor *,sqInt,sqInt,sqInt)'>
	^spanFunction := functionPointer