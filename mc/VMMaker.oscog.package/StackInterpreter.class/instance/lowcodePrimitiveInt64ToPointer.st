inline primitive generated code
lowcodePrimitiveInt64ToPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'char*' >
	value := self internalPopStackInt64.

	result := self cCoerce:
	(self cCoerce: value to: 'intptr_t')
	to: 'char*'.

	self internalPushPointer: result.

