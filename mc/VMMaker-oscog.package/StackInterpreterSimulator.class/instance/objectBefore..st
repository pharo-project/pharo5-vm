testing
objectBefore: addr
	| oop prev |
	oop := objectMemory firstObject.
	[oop < objectMemory endOfMemory] whileTrue:
		[prev := oop.  "look here if debugging prev obj overlapping this one"
		oop := objectMemory objectAfter: oop.
		oop >= addr ifTrue: [^ prev]].
	^0