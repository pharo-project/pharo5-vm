accessing
itemCheck
	^left isNil
		ifTrue: [item] ifFalse: [item + (left itemCheck - right itemCheck)]