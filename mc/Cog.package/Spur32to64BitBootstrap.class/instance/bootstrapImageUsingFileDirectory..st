public access
bootstrapImageUsingFileDirectory: imageName
	| dirName baseName dir |
	dirName := FileDirectory dirPathFor: imageName.
	baseName := (imageName endsWith: '.image')
					ifTrue: [FileDirectory baseNameFor: imageName]
					ifFalse: [FileDirectory localNameFor: imageName].
	dir := dirName isEmpty ifTrue: [FileDirectory default] ifFalse: [FileDirectory default on: dirName].
	self on: (dir fullNameFor: baseName, '.image').
	[self bootstrapImage]
		on: Halt
		do: [:ex|
			"suppress halts from the usual suspects (development time halts)"
			(#(fullGC compactImage) includes: ex signalerContext sender selector)
				ifTrue: [ex resume]
				ifFalse: [ex pass]].
	self writeSnapshot: (dir fullNameFor: baseName, '-64.image')
		headerFlags: imageHeaderFlags
		screenSize: savedWindowSize.
	dir deleteFileNamed: baseName, '-64.changes';
		copyFileNamed: baseName, '.changes' toFileNamed: baseName, '-64.changes'