initialization
checkAssumedCompactClasses
	"Check that the classes the VM assumes are compact have the right indices."
	objectMemory checkCompactIndex: ClassArrayCompactIndex isClass: ClassArray named: 'Array'.
	objectMemory checkCompactIndex: ClassLargeNegativeIntegerCompactIndex isClass: ClassLargeNegativeInteger named: 'LargeNegativeInteger'.
	objectMemory checkCompactIndex: ClassLargePositiveIntegerCompactIndex isClass: ClassLargePositiveInteger named: 'LargePositiveInteger'.
	objectMemory checkCompactIndex: ClassFloatCompactIndex isClass: ClassFloat named: 'Float'.
	objectMemory checkCompactIndex: ClassBlockClosureCompactIndex isClass: ClassBlockClosure named: 'BlockClosure'.
	objectMemory checkCompactIndex: ClassMethodContextCompactIndex isClass: ClassMethodContext named: 'MethodContext'.
	classByteArrayCompactIndex := objectMemory compactIndexOfClass: (objectMemory splObj: ClassByteArray)