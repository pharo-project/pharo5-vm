obj stacks
noCheckPush: objOop onObjStack: objStack
	"Push an element on an objStack.  Split from push:onObjStack: for testing."
	| topx |
	self assert: (self isValidObjStack: objStack).
	self cCode: [] "for debugging markAndTrace: set (MarkStackRecord := OrderedCollection new)"
		inSmalltalk:
			[(self fetchPointer: ObjStackMyx ofObject: objStack) = MarkStackRootIndex ifTrue:
				[MarkStackRecord ifNotNil: [MarkStackRecord addLast: {#push. objOop}]]].
	topx := self fetchPointer: ObjStackTopx ofObject: objStack.
	topx >= ObjStackLimit
		ifTrue:
			[self noCheckPush: objOop
				onObjStack: (self ensureRoomOnObjStackAt: (self fetchPointer: ObjStackMyx ofObject: objStack))]
		ifFalse:
			[self storePointer: ObjStackFixedSlots + topx ofObjStack: objStack withValue: objOop.
			 self storePointer: ObjStackTopx ofObjStack: objStack withValue: topx + 1].
	^objOop