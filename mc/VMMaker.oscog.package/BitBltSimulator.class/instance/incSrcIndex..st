memory access
incSrcIndex: offset
	"if offset is a CObject, this avoids a copy, making the simulation massively faster"
	^ offset isCObjectAccessor
		ifTrue: [sourceIndex += offset]
		ifFalse: [super incSrcIndex: offset]
