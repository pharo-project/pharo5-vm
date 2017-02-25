inline primitive generated code
lowcodePrimitivePointerToInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer result |
	<var: #pointer type: #'char*' >
	<var: #result type: #'sqLong' >
	pointer := self internalPopStackPointer.

	result := self cCoerce: pointer to: 'uintptr_t'.

	self internalPushInt64: result.

