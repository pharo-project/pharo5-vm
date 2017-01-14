memory access
incSrcIndex: offset
	"if offset is a CObject, this avoids a copy, making the simulation massively faster"
	^ sourceIndex isCObjectAccessor
		ifTrue: [sourceIndex += offset]
		ifFalse: [super incSrcIndex: offset]
