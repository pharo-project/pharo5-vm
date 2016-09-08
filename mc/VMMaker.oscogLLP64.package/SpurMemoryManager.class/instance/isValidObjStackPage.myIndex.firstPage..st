obj stacks
isValidObjStackPage: objStackPage myIndex: myx firstPage: isFirstPage
	"Answer if the obj stack at stackRootIndex is valid."
	| page freeOrNextPage index |
	<inline: false>
	(self isValidObjStackPage: objStackPage myIndex: myx) ifFalse:
		[^false].
	freeOrNextPage := self fetchPointer: ObjStackFreex ofObject: objStackPage.
	[freeOrNextPage ~= 0] whileTrue:
		[isFirstPage ifFalse:
			[objStackInvalidBecause := 'free page on other than first page'.
			 invalidObjStackPage := objStackPage.
			 ^false].
		 freeOrNextPage = (self fetchPointer: ObjStackNextx ofObject: objStackPage) ifTrue:
			[objStackInvalidBecause := 'free page = next page'.
			 invalidObjStackPage := freeOrNextPage.
			^false].
		 (self isValidObjStackPage: freeOrNextPage myIndex: myx) ifFalse:
			[objStackInvalidBecause := self stretch: objStackInvalidBecause cat: ', on next page'.
			^false].
		 page := self fetchPointer: ObjStackFreex ofObject: freeOrNextPage.
		 (page = freeOrNextPage
		  or: [page = objStackPage]) ifTrue:
			[objStackInvalidBecause := 'circularity in free page list'.
			 invalidObjStackPage := page.
			^false].
		 freeOrNextPage := page].
	isFirstPage ifTrue:
		[(myx between: self classTableRootSlots and: self classTableRootSlots + self hiddenRootSlots - 1) ifFalse:
			[objStackInvalidBecause := 'myx out of range'.
			 invalidObjStackPage := objStackPage.
			 ^false].
		 (self fetchPointer: myx ofObject: hiddenRootsObj) = objStackPage ifFalse:
			[objStackInvalidBecause := 'firstPage is not root'.
			 invalidObjStackPage := objStackPage.
			 ^false]].
	index := self fetchPointer: ObjStackTopx ofObject: objStackPage.
	(index between: 0 and: ObjStackLimit) ifFalse:
		[objStackInvalidBecause := 'bad topx'.
		 invalidObjStackPage := objStackPage.
		 ^false].
	freeOrNextPage := self fetchPointer: ObjStackNextx ofObject: objStackPage.
	freeOrNextPage = 0 ifTrue:
		[^true].
	freeOrNextPage = objStackPage ifTrue:
		[objStackInvalidBecause := 'circularity in objStack page list'.
		 invalidObjStackPage := objStackPage.
		 ^false].
	^self isValidObjStackPage: freeOrNextPage myIndex: myx firstPage: false