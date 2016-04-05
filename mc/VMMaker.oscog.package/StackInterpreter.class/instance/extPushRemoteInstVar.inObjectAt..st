stack bytecodes
extPushRemoteInstVar: byte1 inObjectAt: objectIndex
	| instVarIndex object |
	instVarIndex := byte1 + (extA << 8).
	extA := 0.
	object := self temporary: objectIndex in: localFP.
	(objectMemory isForwarded: object) ifTrue:
		[object := objectMemory followForwarded: object].
	self internalPush: (objectMemory fetchPointer: instVarIndex ofObject: object).