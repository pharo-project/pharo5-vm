converting
signed64ToUnsigned64: signedValue
	self assert: (signedValue between: -16r8000000000000000 and: 16r7FFFFFFFFFFFFFFF).
	signedValue < 0 ifTrue: [^signedValue + 16r10000000000000000].
	^signedValue