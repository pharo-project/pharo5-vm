class table
countNumClassPagesPreSwizzle: bytesToShift
	"Compute the used size of the class table before swizzling.  Needed to
	 initialize the classTableBitmap which is populated during adjustAllOopsBy:"
	| firstObj classTableRoot nilObjPreSwizzle |
	firstObj := self objectStartingAt: oldSpaceStart. "a.k.a. nilObj"
	"first five objects are nilObj, falseObj, trueObj, freeListsObj, classTableRootObj"
	classTableRoot := self noInlineObjectAfter:
							(self noInlineObjectAfter:
									(self noInlineObjectAfter:
											(self noInlineObjectAfter: firstObj
												limit: endOfMemory)
										limit: endOfMemory)
								limit: endOfMemory)
							limit: endOfMemory.
	nilObjPreSwizzle := oldSpaceStart - bytesToShift.
	numClassTablePages := self numSlotsOf: classTableRoot.
	self assert: numClassTablePages = (self classTableRootSlots + self hiddenRootSlots).
	2 to: numClassTablePages - 1 do:
		[:i|
		(self fetchPointer: i ofObject: classTableRoot) = nilObjPreSwizzle ifTrue:
			[numClassTablePages := i.
			 ^self]]
	