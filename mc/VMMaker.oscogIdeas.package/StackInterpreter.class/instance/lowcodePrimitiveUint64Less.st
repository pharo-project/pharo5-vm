inline primitive generated code
lowcodePrimitiveUint64Less
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second value first |
	<var: #second type: #'sqLong' >
	<var: #value type: #'sqInt' >
	<var: #first type: #'sqLong' >
	second := self internalPopStackInt64.
	first := self internalPopStackInt64.

	value := (self cCoerce: first to: 'uint64_t') <
	(self cCoerce: second to: 'uint64_t') ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

