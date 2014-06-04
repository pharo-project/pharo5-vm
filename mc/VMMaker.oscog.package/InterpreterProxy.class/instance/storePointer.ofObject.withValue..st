object access
storePointer: index ofObject: oop withValue: valuePointer
	^oop instVarAt: index+1 put: valuePointer