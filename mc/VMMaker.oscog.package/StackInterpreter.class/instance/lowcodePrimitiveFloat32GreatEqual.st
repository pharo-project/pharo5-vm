inline primitive generated code
lowcodePrimitiveFloat32GreatEqual
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second value first |
	<var: #second type: #'float' >
	<var: #value type: #'sqInt' >
	<var: #first type: #'float' >
	second := self internalPopStackFloat32.
	first := self internalPopStackFloat32.

	value := first >= second ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

