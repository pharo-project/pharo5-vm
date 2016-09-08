obj stacks
printObjStackPage: objStackPage myIndex: myx pageType: pageType
	| freeOrNextPage page isFirstPage isNextPage isFreePage |
	<inline: false>
	isFirstPage := pageType = ObjStackMyx.
	isNextPage := pageType = ObjStackNextx.
	isFreePage := pageType = ObjStackFreex.
	self printObjStackPage: objStackPage
		myIndex: myx
		tag: (isFirstPage ifTrue: ['head'] ifFalse: [isFreePage ifTrue: ['free'] ifFalse: ['next']]).
	(isFirstPage or: [isNextPage]) ifTrue:
		[coInterpreter tab; print: 'topx: '; printNum: (self fetchPointer: ObjStackTopx ofObject: objStackPage); print: ' next: '; printHex: (self fetchPointer: ObjStackNextx ofObject: objStackPage).
		 isFirstPage ifTrue:
			[coInterpreter print: ' free: '; printHex: (self fetchPointer: ObjStackFreex ofObject: objStackPage)].
		 coInterpreter cr].
	isFirstPage ifTrue:
		[freeOrNextPage := self fetchPointer: ObjStackFreex ofObject: objStackPage.
		 [freeOrNextPage ~= 0] whileTrue:
			[self printObjStackPage: freeOrNextPage myIndex: myx pageType: ObjStackFreex.
			 page := self fetchPointer: ObjStackFreex ofObject: freeOrNextPage.
			 (page = freeOrNextPage
			  or: [page = objStackPage]) ifTrue:
				[coInterpreter print: 'circularity in free page list!!'; cr.
				 page := 0].
			 freeOrNextPage := page]].
	freeOrNextPage := self fetchPointer: ObjStackNextx ofObject: objStackPage.
	freeOrNextPage ~= 0 ifTrue:
		[self printObjStackPage: freeOrNextPage myIndex: myx pageType: ObjStackNextx]