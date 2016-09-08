obj stacks
markAndTraceObjStack: stackOrNil andContents: markAndTraceContents
	"An obj stack is a stack of objects stored in a hidden root slot, such
	 as the markStack or the ephemeronQueue.  It is a linked list of
	 segments, with the hot end at the head of the list.  It is a word object.
	 The stack pointer is in ObjStackTopx and 0 means empty."
	<inline: false>
	| index field |
	stackOrNil = nilObj ifTrue:
		[^self].
	self setIsMarkedOf: stackOrNil to: true.
	self assert: (self numSlotsOfAny: stackOrNil) = ObjStackPageSlots.
	field := self fetchPointer: ObjStackNextx ofObject: stackOrNil.
	field ~= 0 ifTrue:
		[self markAndTraceObjStack: field andContents: markAndTraceContents].
	field := stackOrNil.
	[field := self fetchPointer: ObjStackFreex ofObject: field.
	 field ~= 0] whileTrue:
		[self setIsMarkedOf: field to: true].
	markAndTraceContents ifFalse:
		[^self].
	"There are four fixed slots in an obj stack, and a Topx of 0 indicates empty, so
	  if there were 6 slots in an oop stack, full would be 2, and the last 0-rel index is 5."
	index := (self fetchPointer: ObjStackTopx ofObject: stackOrNil) + ObjStackNextx.
	[index >= ObjStackFixedSlots] whileTrue:
		[field := self followObjField: index ofObject: stackOrNil.
		 (self isImmediate: field) ifFalse:
			[self markAndTrace: field].
		 index := index - 1]