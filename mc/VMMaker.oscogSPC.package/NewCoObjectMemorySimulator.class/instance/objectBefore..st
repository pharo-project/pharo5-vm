testing
objectBefore: addr
	| oop prev |
	oop := self firstObject.
	[oop < freeStart] whileTrue:
		[prev := oop.  "look here if debugging prev obj overlapping this one"
		oop := self objectAfter: oop.
		oop >= addr ifTrue: [^ prev]].
	^0