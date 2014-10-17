public access
bootstrapImageUsingFileReference: imageName
	| dirName baseName dir |
	dirName := imageName asFileReference parent fullName.
	baseName := (imageName endsWith: '.image')
		ifTrue: [ imageName asFileReference base ]
		ifFalse: [ (imageName, '.image') asFileReference base ].
	dir := dirName asFileReference.
	self on: (dir / (baseName, '.image')) fullName.
	[self transform]
		on: Halt
		do: [:ex|
			"suppress halts from the usual suspects (development time halts)"
			(#(fullGC compactImage) includes: ex signalerContext sender selector)
				ifTrue: [ex resume]
				ifFalse: [ex pass]].
	self writeSnapshot: (dir / (baseName, '-spur.image')) fullName
		ofTransformedImage: newHeap
		headerFlags: oldInterpreter getImageHeaderFlags
		screenSize: oldInterpreter savedWindowSize.
	(dir / (baseName, '.changes')) copyTo: (dir / (baseName, '-spur.changes'))