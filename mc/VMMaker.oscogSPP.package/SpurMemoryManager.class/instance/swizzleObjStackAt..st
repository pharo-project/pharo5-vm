obj stacks
swizzleObjStackAt: objStackRootIndex
	"On load, swizzle the pointers in an obj stack. Answer the obj stack's oop."
	| firstPage page stackOrNil index field |
	firstPage := stackOrNil := self fetchPointer: objStackRootIndex ofObject: hiddenRootsObj.
	stackOrNil = nilObj ifTrue:
		[^stackOrNil].
	[self assert: (self numSlotsOfAny: stackOrNil) = ObjStackPageSlots.
	 self assert: (self fetchPointer: ObjStackMyx ofObject: stackOrNil) = objStackRootIndex.
	 "There are four fixed slots in an obj stack, and a Topx of 0 indicates empty, so
	   if there were 5 slots in an oop stack, full would be 2, and the last 0-rel index is 4.
	   Hence the last index is topx + fixed slots - 1, or topx + ObjStackNextx"
	 index := (self fetchPointer: ObjStackTopx ofObject: stackOrNil) + ObjStackNextx.
	 "swizzle fields including ObjStackNextx, excluding ObjStackFreex and leave field containing the next link."
	 [field := self fetchPointer: index ofObject: stackOrNil.
	  (field = 0 or: [self isImmediate: field]) ifFalse:
		[field := segmentManager swizzleObj: field.
		 self storePointer: index ofObjStack: stackOrNil withValue: field].
	  (index := index - 1) >= ObjStackNextx] whileTrue.
	 (stackOrNil := field) ~= 0] whileTrue.
	(stackOrNil := self fetchPointer: ObjStackFreex ofObject: firstPage) ~=  0 ifTrue:
		[page := firstPage.
		 [stackOrNil := segmentManager swizzleObj: stackOrNil.
		  self storePointer: ObjStackFreex ofObjStack: page withValue: stackOrNil.
		  page := stackOrNil.
		  (stackOrNil := self fetchPointer: ObjStackFreex ofObject: page) ~=  0] whileTrue].
	self assert: (self isValidObjStackAt: objStackRootIndex).
	^self fetchPointer: objStackRootIndex ofObject: hiddenRootsObj