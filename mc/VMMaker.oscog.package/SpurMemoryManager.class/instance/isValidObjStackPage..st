obj stacks
isValidObjStackPage: objStackPage
	"for the Spur 32- to 64-bit bootstrap"
	<doNotGenerate>
	^self
		isValidObjStackPage: objStackPage
		myIndex: ((self numSlotsOfAny: objStackPage) = ObjStackPageSlots ifTrue:
					[self fetchPointer: ObjStackMyx ofObject: objStackPage])