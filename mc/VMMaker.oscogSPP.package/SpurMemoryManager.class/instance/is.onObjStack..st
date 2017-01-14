obj stacks
is: oop onObjStack: objStack
	<inline: false>
	| index nextPage |
	objStack = nilObj ifTrue:
		[^false].
	self assert: (self numSlotsOfAny: objStack) = ObjStackPageSlots.
	"There are four fixed slots in an obj stack, and a Topx of 0 indicates empty, so
	  if there were 6 slots in an oop stack, full would be 2, and the last 0-rel index is 5."
	index := (self fetchPointer: ObjStackTopx ofObject: objStack) + ObjStackNextx.
	[index >= ObjStackFixedSlots] whileTrue:
		[oop = (self fetchPointer: index ofObject: objStack) ifTrue:
			[^true].
		 index := index - 1].
	nextPage := self fetchPointer: ObjStackNextx ofObject: objStack.
	nextPage ~= 0 ifTrue:
		[(self is: oop onObjStack: nextPage) ifTrue:
			[^true]].
	^false