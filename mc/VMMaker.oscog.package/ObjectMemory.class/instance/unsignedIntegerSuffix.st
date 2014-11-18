as yet unclassified
unsignedIntegerSuffix
	"Answer the suffix that should be appended to unsigned integer literals in generated code."

	^self wordSize = 4 ifTrue: ['UL'] ifFalse: ['ULL']