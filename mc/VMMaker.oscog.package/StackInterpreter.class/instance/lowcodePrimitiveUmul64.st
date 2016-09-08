inline primitive generated code
lowcodePrimitiveUmul64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second result first |
	<var: #second type: #'sqLong' >
	<var: #result type: #'sqLong' >
	<var: #first type: #'sqLong' >
	second := self internalPopStackInt64.
	first := self internalPopStackInt64.

	result := (self cCoerce: first to: 'uint64_t') *
	(self cCoerce: second to: 'uint64_t').

	self internalPushInt64: result.

