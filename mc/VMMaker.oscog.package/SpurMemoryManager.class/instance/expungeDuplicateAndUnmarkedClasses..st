class table
expungeDuplicateAndUnmarkedClasses: expungeUnmarked
	"Bits have been set in the classTableBitmap corresponding to
	 used classes.  Any class in the class table that does not have a
	 bit set has no instances with that class index.  However, becomeForward:
	 can create duplicate entries, and these duplicate entries wont match their
	 identityHash. So expunge duplicates by eliminating unmarked entries that
	 don't occur at their identityHash."
	1 to: numClassTablePages - 1 do: "Avoid expunging the puns by not scanning the 0th page."
		[:i| | classTablePage |
		classTablePage := self fetchPointer: i ofObject: hiddenRootsObj.
		 0 to: self classTablePageSize - 1 do:
			[:j| | classOrNil classIndex |
			 classOrNil := self fetchPointer: j ofObject: classTablePage.
			 classIndex := i << self classTableMajorIndexShift + j.
			 self assert: (classOrNil = nilObj or: [coInterpreter addressCouldBeClassObj: classOrNil]).
			 "only remove a class if it is at a duplicate entry or it is unmarked and we're expunging unmarked classes."
			 classOrNil = nilObj
				ifTrue:
					[classIndex < classTableIndex ifTrue:
						[classTableIndex := classIndex]]
				ifFalse:
					[((expungeUnmarked and: [(self isMarked: classOrNil) not])
					   or: [(self rawHashBitsOf: classOrNil) ~= classIndex]) ifTrue:
						[self storePointerUnchecked: j
							ofObject: classTablePage
							withValue: nilObj.
						 "but if it is marked, it should still be in the table at its correct index."
						 self assert: ((expungeUnmarked and: [(self isMarked: classOrNil) not])
									or: [(self classAtIndex: (self rawHashBitsOf: classOrNil)) = classOrNil]).
						 "If the removed class is before the classTableIndex, set the
						  classTableIndex to point to the empty slot so as to reuse it asap."
						 classIndex < classTableIndex ifTrue:
							[classTableIndex := classIndex]]]]].
	"classTableIndex must never index the first page, which is reserved for classes known to the VM."
	self assert: classTableIndex >= (1 << self classTableMajorIndexShift)