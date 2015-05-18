obj stacks
popObjStack: objStack
	| topx top nextPage myx |
	self eassert: [self isValidObjStack: objStack].
	topx := self fetchPointer: ObjStackTopx ofObject: objStack.
	topx = 0 ifTrue:
		[self assert: (self fetchPointer: ObjStackNextx ofObject: objStack) = 0.
		 self cCode: [] "for debugging markAndTrace: set (MarkStackRecord := OrderedCollection new)"
			inSmalltalk:
				[(self fetchPointer: ObjStackMyx ofObject: objStack) = MarkStackRootIndex ifTrue:
					[MarkStackRecord ifNotNil:
						[MarkStackRecord addLast: {#EMPTY. nil}]]].
		^nil].
	topx := topx - 1.
	top := self fetchPointer: topx + ObjStackFixedSlots ofObject: objStack.
	self cCode: [] "for debugging markAndTrace: set (MarkStackRecord := OrderedCollection new)"
		inSmalltalk:
			[(self fetchPointer: ObjStackMyx ofObject: objStack) = MarkStackRootIndex ifTrue:
				[MarkStackRecord ifNotNil:
					[(MarkStackRecord last first = #push and: [MarkStackRecord last last = top])
						ifTrue: [MarkStackRecord removeLast]
						ifFalse: [MarkStackRecord addLast: {#pop. top}]]]].
	self storePointer: ObjStackTopx ofObjStack: objStack withValue: topx.
	(topx = 0
	 and: [(nextPage := self fetchPointer: ObjStackNextx ofObject: objStack) ~= 0])
		ifTrue:
			[self storePointer: ObjStackFreex ofObjStack: nextPage withValue: objStack.
			 self storePointer: ObjStackNextx ofObjStack: objStack withValue: 0.
			 myx := self fetchPointer: ObjStackMyx ofObject: objStack.
			 self updateRootOfObjStackAt: myx with: nextPage.
			 self eassert: [self isValidObjStack: nextPage]]
		ifFalse:
			[self eassert: [self isValidObjStack: objStack]].
	^top