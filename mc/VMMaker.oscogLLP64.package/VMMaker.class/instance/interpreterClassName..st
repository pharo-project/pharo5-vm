generate sources
interpreterClassName: aString
	| tmp |
	tmp := Smalltalk at: aString asSymbol ifAbsent: [nil].
	tmp isBehavior
		ifTrue: [self interpreterClass: tmp]
		ifFalse: [self invalidClassName]