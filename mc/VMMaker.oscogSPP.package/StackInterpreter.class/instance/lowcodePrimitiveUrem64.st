inline primitive generated code
lowcodePrimitiveUrem64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second result first |
	<var: #second type: #'sqLong' >
	<var: #result type: #'sqLong' >
	<var: #first type: #'sqLong' >
	second := self internalPopStackInt64.
	first := self internalPopStackInt64.

	result := (self cCoerce: first to: 'unsigned int') \\
	(self cCoerce: second to: 'unsigned int').

	self internalPushInt64: result.

