public access
bootstrapImageUsingFileDirectory: imageName
	| dirName baseName dir |
	dirName := FileDirectory dirPathFor: imageName.
	baseName := (imageName endsWith: '.image')
					ifTrue: [FileDirectory baseNameFor: imageName]
					ifFalse: [FileDirectory localNameFor: imageName].
	dir := dirName isEmpty ifTrue: [FileDirectory default] ifFalse: [FileDirectory default on: dirName].
	self on: (dir fullNameFor: baseName, '.image').
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
	dir deleteFileNamed: baseName, '-spur.changes';
		copyFileNamed: baseName, '.changes' toFileNamed: baseName, '-spur.changes'