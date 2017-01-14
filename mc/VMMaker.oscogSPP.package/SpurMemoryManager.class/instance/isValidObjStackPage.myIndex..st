obj stacks
isValidObjStackPage: objStackPage myIndex: myx
	"Just check the page itself."
	<inline: false>
	(self classIndexOf: objStackPage) = self wordSizeClassIndexPun ifFalse:
		[objStackInvalidBecause := 'wrong class index'.
		 invalidObjStackPage := objStackPage.
		 ^false].
	(self formatOf: objStackPage) = self wordIndexableFormat ifFalse:
		[objStackInvalidBecause := 'wrong format'.
		 invalidObjStackPage := objStackPage.
		 ^false].
	(self numSlotsOfAny: objStackPage) = ObjStackPageSlots ifFalse:
		[objStackInvalidBecause := 'wrong num slots'.
		 invalidObjStackPage := objStackPage.
		 ^false].
	myx = (self fetchPointer: ObjStackMyx ofObject: objStackPage) ifFalse:
		[objStackInvalidBecause := 'wrong myx'.
		 invalidObjStackPage := objStackPage.
		 ^false].
	(marking and: [(self isMarked: objStackPage) not]) ifTrue:
		[objStackInvalidBecause := 'marking but page is unmarked'.
		 invalidObjStackPage := objStackPage.
		 ^false].
	^true