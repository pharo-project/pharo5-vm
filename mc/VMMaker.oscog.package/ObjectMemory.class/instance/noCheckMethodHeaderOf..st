method access
noCheckMethodHeaderOf: methodObj
	"Answer the method header of a CompiledMethod object."
	^self fetchPointer: HeaderIndex ofObject: methodObj