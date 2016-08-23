utilities
baseTypeForPointerType: aCType
	"Answer the type of the referent of a pointer type."
	self assert: aCType last == $*.
	^self baseTypeForType: aCType allButLast