inline primitive generated code
lowcodePrimitiveUrem32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second result first |
	<var: #second type: #'sqInt' >
	<var: #result type: #'sqInt' >
	<var: #first type: #'sqInt' >
	second := self internalPopStackInt32.
	first := self internalPopStackInt32.

	result := (self cCoerce: first to: 'unsigned int') \\
	(self cCoerce: second to: 'unsigned int').

	self internalPushInt32: result.

