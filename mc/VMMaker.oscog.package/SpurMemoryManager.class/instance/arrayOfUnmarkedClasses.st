image segment in/out
arrayOfUnmarkedClasses
	| nClasses classes i |
	nClasses := 0.
	self classTableEntriesDo:
		[:class :ignored|
		 (self isMarked: class) ifFalse:
			[nClasses := nClasses + 1]].
	nClasses = 0 ifTrue:
		[^nilObj].
	classes := self allocateSlots: nClasses format: self arrayFormat classIndex: ClassArrayCompactIndex.
	classes ifNil:
		[^self integerObjectOf: PrimErrNoMemory].
	i := 0.
	self classTableEntriesDo:
		[:class :ignored|
		 (self isMarked: class) ifFalse:
			[self storePointer: i ofObject: classes withValue: class.
			 i := i + 1]].
	self assert: nClasses = i.
	^classes