public access
bootstrapImageUsingFileReference: imageName
	| imageRef changesRef image64Ref changes64Ref dir |
	
	dir := imageName asFileReference parent.
	imageRef := (dir / imageName asFileReference base) withExtension: 'image'.
	changesRef := (dir / imageName asFileReference base) withExtension: 'changes'.
	image64Ref := (dir / (imageName asFileReference base, '-64')) withExtension: 'image'.
	changes64Ref := (dir / (imageName asFileReference base, '-64')) withExtension: 'changes'.
	
	self on: imageRef fullName.
	[self bootstrapImage]
		on: Halt
		do: [:ex|
			"suppress halts from the usual suspects (development time halts)"
			(#(fullGC compactImage) includes: ex signalerContext sender selector)
				ifTrue: [ex resume]
				ifFalse: [ex pass]].
	self writeSnapshot: image64Ref fullName
		headerFlags: imageHeaderFlags
		screenSize: savedWindowSize.
		
	changes64Ref ensureDelete.
	changesRef copyTo: changes64Ref.