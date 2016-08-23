image save/restore
getShortFromFile: aFile swap: swapFlag
	| aShort |
	aShort := self nextShortFrom: aFile.
	^swapFlag 
		ifTrue: [(aShort bitShift: -8) + ((aShort bitAnd: 16rFF) bitShift: 8)]
		ifFalse: [aShort]