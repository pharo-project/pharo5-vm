inline primitive generated code
lowcodePrimitiveOopEqual
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second value first |
	<var: #second type: #'sqInt' >
	<var: #value type: #'sqInt' >
	<var: #first type: #'sqInt' >
	second := self internalPopStack.
	first := self internalPopStack.

	value := first = second ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

