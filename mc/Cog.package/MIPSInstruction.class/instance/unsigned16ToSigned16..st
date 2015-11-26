fields
unsigned16ToSigned16: unsignedValue
	self assert: (unsignedValue between: 0 and: 16rFFFF).
	unsignedValue >= 16r8000 ifTrue: [^unsignedValue - 16r10000].
	^unsignedValue