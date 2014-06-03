accessing
unsignedShortAt: byteIndex put: aValue
	"Compatiblity with the ByteArray & Alien methods of the same name."
	| zi |
	(aValue < 0 or: [aValue > 16rFFFF])  ifTrue:
		[^self errorImproperStore].
	((zi := byteIndex - 1) bitAnd: 1) = 0
		ifTrue: [(zi bitAnd: 2) = 0
					ifTrue: [self at: (zi := zi // 4 + 1) put: (16rFFFF0000 bitAnd: (self at: zi)) + aValue]
					ifFalse: [self at: (zi := zi - 2 // 4 + 1) put: (16rFFFF bitAnd: (self at: zi)) + (aValue bitShift: 16)]]
		ifFalse: [self notYetImplemented].
	^aValue