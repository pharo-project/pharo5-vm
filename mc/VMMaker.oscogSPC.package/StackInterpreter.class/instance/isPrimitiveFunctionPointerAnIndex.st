primitive support
isPrimitiveFunctionPointerAnIndex
	"We save slots in the method cache by using the primitiveFunctionPointer
	 to hold either a function pointer or the index of a quick primitive. Since
	 quick primitive indices are small they can't be confused with function
	 addresses. "
	^(self cCoerce: primitiveFunctionPointer to: #'usqIntptr_t') <= MaxQuickPrimitiveIndex