inline primitive generated code
lowcodePrimitiveXor64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second result first |
	<var: #second type: #'sqLong' >
	<var: #result type: #'sqLong' >
	<var: #first type: #'sqLong' >
	second := self internalPopStackInt64.
	first := self internalPopStackInt64.

	result := first bitXor: second.

	self internalPushInt64: result.

