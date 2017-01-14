inline primitive generated code
lowcodePrimitiveFloat64Less
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second value first |
	<var: #second type: #'double' >
	<var: #value type: #'sqInt' >
	<var: #first type: #'double' >
	second := self internalPopStackFloat64.
	first := self internalPopStackFloat64.

	value := first < second ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

