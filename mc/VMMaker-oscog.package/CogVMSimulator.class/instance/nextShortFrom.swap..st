initialization
nextShortFrom: aStream swap: swapFlag
	| aShort |
	aShort := self nextShortFrom: aStream.
	^swapFlag 
		ifTrue: [(aShort bitShift: -8) + ((aShort bitAnd: 16rFF) bitShift: 8)]
		ifFalse: [aShort]