translation
unsignedIntegerSuffix
	"Answer the suffix that should be appended to unsigned integer literals in generated code."

	^BytesPerWord = 4 ifTrue: ['UL'] ifFalse: ['ULL']