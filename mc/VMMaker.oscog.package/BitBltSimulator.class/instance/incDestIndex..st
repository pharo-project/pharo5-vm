memory access
incDestIndex: offset
	"if offset is a CObject, this avoids a copy, making the simulation massively faster"
	^ destIndex isCObjectAccessor
		ifTrue: [destIndex += offset]
		ifFalse: [super incDestIndex: offset]
