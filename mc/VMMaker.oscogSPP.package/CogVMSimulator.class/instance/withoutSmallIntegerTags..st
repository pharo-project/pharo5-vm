frame access
withoutSmallIntegerTags: anInteger
	self assert: (anInteger >= 0 and: [anInteger highBit <= 32]).
	^(anInteger bitAnd: 16r80000000) ~= 0
		ifTrue: ["negative"
				(anInteger bitAnd: 16r7FFFFFFE) - 16r80000000]
		ifFalse: ["positive"
				anInteger - 1]