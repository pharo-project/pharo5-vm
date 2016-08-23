frame access
withoutSmallIntegerTags: anInteger
	| signBit |
	self assert: (anInteger >= 0 and: [anInteger highBit <= (objectMemory wordSize * 8)]).
	signBit := 1 << (objectMemory wordSize * 8 - 1).
	^(anInteger bitAnd: signBit) ~= 0
		ifTrue: ["negative"
				(anInteger bitClear: signBit + 1) - signBit]
		ifFalse: ["positive"
				anInteger - 1]