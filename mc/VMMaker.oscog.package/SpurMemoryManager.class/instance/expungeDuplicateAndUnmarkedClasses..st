class table
expungeDuplicateAndUnmarkedClasses: expungeUnmarked
	"Bits have been set in the classTableBitmap corresponding to
	 used classes.  Any class in the class table that does not have a
	 bit set has no instances with that class index.  However, becomeForward:
	 can create duplicate entries, and these duplicate entries
		a) won't have a bit set on load (because there are no forwarders on load),
		b) wont match their identityHash.
	 So expunge duplicates by eliminating unmarked entries that don't occur at
	 their identityHash.
	 Further, any class in the table that is unmarked will also not have a bit set so
	 eliminate unmarked classes using the bitmap too."
	1 to: numClassTablePages - 1 do: "Avoid expunging the puns by not scanning the 0th page."
		[:i| | classTablePage |
		"optimize scan by only scanning bitmap in regions that have pages."
		classTablePage := self fetchPointer: i ofObject: hiddenRootsObj.
		classTablePage ~= nilObj ifTrue:
			[i << self classTableMajorIndexShift
				to: i << self classTableMajorIndexShift + self classTableMinorIndexMask
				by: 8
				do: [:majorBitIndex| | byteIndex byte classIndex classOrNil |
					"optimize scan by scanning a byte of indices (8 indices) at a time"
					byteIndex := majorBitIndex / BitsPerByte.
					byte := classTableBitmap at: byteIndex.
					byte ~= 255 ifTrue:
						[0 to: 7 do:
							[:minorBitIndex|
							(byte noMask: 1 << minorBitIndex) ifTrue:
								[classIndex := majorBitIndex + minorBitIndex.
								 classOrNil := self fetchPointer: (classIndex bitAnd: self classTableMinorIndexMask)
												   ofObject: classTablePage.
								 self assert: (self classAtIndex: classIndex) = classOrNil.
								 self assert: (classOrNil = nilObj or: [coInterpreter addressCouldBeClassObj: classOrNil]).
								 "only remove a class if it is at a duplicate entry or it is unmarked and we're expunging unmarked classes."
								 classOrNil = nilObj
									ifTrue:
										[classIndex < classTableIndex ifTrue:
											[classTableIndex := classIndex]]
									ifFalse:
										[((expungeUnmarked and: [(self isMarked: classOrNil) not])
										  or: [(self rawHashBitsOf: classOrNil) ~= classIndex]) ifTrue:
										[self storePointerUnchecked: (classIndex bitAnd: self classTableMinorIndexMask)
											ofObject: classTablePage
											withValue: nilObj.
										 "but if it is marked, it should still be in the table at its correct index."
										 self assert: ((expungeUnmarked and: [(self isMarked: classOrNil) not])
													or: [(self classAtIndex: (self rawHashBitsOf: classOrNil)) = classOrNil]).
										 "If the removed class is before the classTableIndex, set the
										  classTableIndex to point to the empty slot so as to reuse it asap."
										 classIndex < classTableIndex ifTrue:
											[classTableIndex := classIndex]]]]]]]]]