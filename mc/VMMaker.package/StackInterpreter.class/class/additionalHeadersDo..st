translation
additionalHeadersDo: aBinaryBlock
	"Evaluate aBinaryBlock with the names and contents of
	 any additional header files that need to be generated."
	self objectMemoryClass additionalHeadersDo: aBinaryBlock.
	aBinaryBlock
		value: 'vmCallback.h'
		value: self vmCallbackHeader