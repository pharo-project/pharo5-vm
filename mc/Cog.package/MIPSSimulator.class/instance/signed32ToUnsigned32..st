converting
signed32ToUnsigned32: signedValue
	self assert: (signedValue between: -16r80000000 and: 16r7FFFFFFF).
	signedValue < 0 ifTrue: [^signedValue + 16r100000000].
	^signedValue