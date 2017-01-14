accessing
byteSizeOf: anOop
	| obj elementSize |
	obj := self objectForOop: anOop.
	([obj class isImmediateClass]
		on: MessageNotUnderstood
		do: [:ex| obj class == SmallInteger]) ifTrue:
		[^0].
	elementSize := 
		[obj class elementSize]
			on: MessageNotUnderstood
			do: [:ex| obj class isBytes ifTrue: [1] ifFalse: [Smalltalk wordSize]].
	^obj basicSize * elementSize