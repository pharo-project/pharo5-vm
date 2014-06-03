become
freeObject: obj header: objHeader
	| objHeaderBytes objHeaderType objSize |
	(self isYoungRootHeader: objHeader) ifTrue:
		[self removeYoungRoot: obj].
	objHeaderType := objHeader bitAnd: TypeMask.
	objHeaderBytes := headerTypeBytes at: objHeaderType.
	(objHeaderType bitAnd: 1) = 1 "HeaderTypeClass or HeaderTypeShort"
		ifTrue: [objSize := objHeader bitAnd: SizeMask]
		ifFalse:
			[objHeaderType = HeaderTypeFree
				ifTrue: [^nil]. "already free"
			objSize := (self sizeHeader: obj) bitAnd: LongSizeMask].
	self assert: (objSize + objHeaderBytes bitAnd: AllButTypeMask) = (objSize + objHeaderBytes).
	self longAt: obj - objHeaderBytes
		put: ((objSize + objHeaderBytes) bitOr: HeaderTypeFree)