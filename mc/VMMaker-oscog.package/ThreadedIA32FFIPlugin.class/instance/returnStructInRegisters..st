marshalling
returnStructInRegisters: returnStructSize
	"Answer if a struct result of a given size is returned in memory or not."
	<cmacro: '(sz) (WIN32_X86_STRUCT_RETURN && (sz) <= 8 && !((sz)&((sz)-1)))'>
	^returnStructSize <= 8 and: [(returnStructSize bitAnd: returnStructSize - 1) = 0]