memory access
methodHeaderOf: methodObj
	"Answer the method header of a CompiledMethod object."
	self assert: (self isCompiledMethod: methodObj).
	^self fetchPointer: HeaderIndex ofObject: methodObj