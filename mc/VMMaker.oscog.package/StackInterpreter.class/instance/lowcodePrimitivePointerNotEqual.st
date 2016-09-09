inline primitive generated code
lowcodePrimitivePointerNotEqual
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second value first |
	<var: #second type: #'char*' >
	<var: #value type: #'sqInt' >
	<var: #first type: #'char*' >
	second := self internalPopStackPointer.
	first := self internalPopStackPointer.

	value := first ~= second ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

