obj stacks
followForwardedInObjStack: objStack atIndex: objStackRootIndex
	"Post-compact, follow forwarders in an obj stack."
	| firstPage stackOrNil index field |
	objStack = nilObj ifTrue:
		[^objStack].
	stackOrNil := objStack.
	(self isForwarded: stackOrNil) ifTrue:
		[stackOrNil := self followForwarded: stackOrNil.
		 self updateRootOfObjStackAt: objStackRootIndex with: stackOrNil].
	firstPage := stackOrNil.
	[self assert: (self numSlotsOfAny: stackOrNil) = ObjStackPageSlots.
	 self assert: (self fetchPointer: ObjStackMyx ofObject: stackOrNil) = objStackRootIndex.
	 "There are four fixed slots in an obj stack, and a Topx of 0 indicates empty, so
	   if there were 5 slots in an oop stack, full would be 2, and the last 0-rel index is 4.
	   Hence the last index is topx + fixed slots - 1, or topx + ObjStackNextx"
	 index := (self fetchPointer: ObjStackTopx ofObject: stackOrNil) + ObjStackNextx.
	 "follow forwarded fields including ObjStackNextx and leave field containing the next link."
	 [field := self fetchPointer: index ofObject: stackOrNil.
	  (field ~= 0 and: [(self isNonImmediate: field) and: [self isForwarded: field]]) ifTrue:
		[field := self followForwarded: field.
		 self storePointer: index ofObjStack: stackOrNil withValue: field].
	  (index := index - 1) > ObjStackFreex] whileTrue.
	  self assert: field = (self fetchPointer: ObjStackNextx ofObject: stackOrNil).
	 (stackOrNil := field) ~= 0] whileTrue.
	[stackOrNil := self fetchPointer: ObjStackFreex ofObject: firstPage.
	 stackOrNil ~= 0] whileTrue:
		[(self isForwarded: stackOrNil) ifTrue:
			[stackOrNil := self followForwarded: stackOrNil.
			 self storePointer: ObjStackFreex ofObjStack: firstPage withValue: stackOrNil].
		 firstPage := stackOrNil].
	self assert: (self isValidObjStackAt: objStackRootIndex)