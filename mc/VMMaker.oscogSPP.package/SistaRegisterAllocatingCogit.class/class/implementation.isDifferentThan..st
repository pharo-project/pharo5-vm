clone maintennance
implementation: aMethodReference isDifferentThan: bMethodReference
	^aMethodReference isValid
	 and: [bMethodReference isValid
			ifTrue: [aMethodReference sourceString ~= bMethodReference sourceString]
			ifFalse: [true]]