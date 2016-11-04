inline primitive generated code
lowcodePrimitiveUint32Less
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second value first |
	<var: #second type: #'sqInt' >
	<var: #value type: #'sqInt' >
	<var: #first type: #'sqInt' >
	second := self internalPopStackInt32.
	first := self internalPopStackInt32.

	value := (self cCoerce: first to: 'unsigned int') <
	(self cCoerce: second to: 'unsigned int') ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.

