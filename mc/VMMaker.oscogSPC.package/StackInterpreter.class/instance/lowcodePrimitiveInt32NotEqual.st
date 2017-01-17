inline primitive generated code
lowcodePrimitiveInt32NotEqual
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second value first |
	<var: #second type: #'sqInt' >
	<var: #value type: #'sqInt' >
	<var: #first type: #'sqInt' >
	second := self internalPopStackInt32.
	first := self internalPopStackInt32.

	value := first ~= second ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

