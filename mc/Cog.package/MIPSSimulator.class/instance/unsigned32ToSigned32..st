converting
unsigned32ToSigned32: unsignedValue
	self assert: (unsignedValue between: 0 and: 16rFFFFFFFF).
	unsignedValue >= 16r80000000 ifTrue: [^unsignedValue - 16r100000000].
	^unsignedValue