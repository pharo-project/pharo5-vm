obj stacks
stackValue: offset ofObjStack: objStackPage
	| topx nextPage |
	self assert: offset >= 0.
	topx := self fetchPointer: ObjStackTopx ofObject: objStackPage.
	offset < topx ifTrue:
		[^self fetchPointer: ObjStackTopx + offset ofObject: objStackPage].
	nextPage := self fetchPointer: ObjStackNextx ofObject: objStackPage.
	nextPage = 0 ifTrue:
		[^nil].
	^self stackValue: offset - topx ofObjStack: nextPage