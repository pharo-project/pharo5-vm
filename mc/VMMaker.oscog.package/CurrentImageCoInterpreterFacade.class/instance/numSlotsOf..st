accessing
numSlotsOf: objOop
	"Answer the number of slots in the given non-immediate object.
	 Does not adjust the size of contexts by stackPointer."
	| obj elementSize wordSize |
	obj := self objectForOop: objOop.
	obj = objOop ifTrue:
		[^objectMemory numSlotsOf: objOop].
	self deny: ([obj class isImmediateClass]
				on: MessageNotUnderstood
				do: [:ex| obj class == SmallInteger]).
	wordSize := Smalltalk wordSize.
	elementSize := 
		[obj class elementSize]
			on: MessageNotUnderstood
			do: [:ex| obj class isBytes ifTrue: [1] ifFalse: [wordSize]].
	wordSize = 4 ifTrue:
		[^elementSize caseOf: {
			[1]	->	[obj basicSize + 3 // wordSize].
			[2]	->	[obj basicSize * 2 + 3 // wordSize].
			[4]	->	[obj basicSize + obj class instSize] }].
	^elementSize caseOf: {
		[1]	->	[obj basicSize + (wordSize - 1) // wordSize].
		[2]	->	[obj basicSize * 2 + (wordSize - 1) // wordSize].
		[4]	->	[obj basicSize * 2 + (wordSize - 1) // wordSize].
		[8]	->	[obj basicSize + obj class instSize] }