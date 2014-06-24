public access
bootstrapImage: imageName
	| dirName baseName dir |
	dirName := imageName asFileReference parent fullName.
	baseName := (imageName endsWith: '.image')
					ifTrue: [ imageName asFileReference basename ]
					ifFalse: [ (imageName, '.image') asFileReference basename ].
	dir := dirName asFileReference.
	self on: (dir / baseName) fullName.
	[self transform]
		on: Halt
		do: [:ex|
			"suppress halts from the usual suspects (development time halts)"
			(#(fullGC compactImage) includes: ex signalerContext sender selector)
				ifTrue: [ex resume]
				ifFalse: [ex pass]].
	self writeSnapshot: (dir fullNameFor: baseName, '-spur.image')
		ofTransformedImage: newHeap
		headerFlags: oldInterpreter getImageHeaderFlags
		screenSize: oldInterpreter savedWindowSize.
	dir copyFileNamed: (dir fullNameFor: baseName, '.changes')
		toFileNamed: (dir fullNameFor: baseName, '-spur.changes')