development support
saveTransformedImage
	ImageHeaderFlags := oldInterpreter getImageHeaderFlags.
	ImageName := oldInterpreter imageName.
	newHeap coInterpreter: nil.
	(newHeap class allInstVarNames select: [:ivn| ivn beginsWith: 'stat']) do:
		[:ivn| newHeap instVarNamed: ivn put: 0].
	TransformedImage := newHeap veryDeepCopy