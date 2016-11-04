inline primitive generated code
lowcodePrimitiveInt32ToPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqInt' >
	<var: #result type: #'char*' >
	value := self internalPopStackInt32.

	result := self cCoerce: value to: 'uintptr_t'.

	self internalPushPointer: result.

