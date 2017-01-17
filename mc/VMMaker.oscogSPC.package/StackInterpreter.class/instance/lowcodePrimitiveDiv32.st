inline primitive generated code
lowcodePrimitiveDiv32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second result first |
	<var: #second type: #'sqInt' >
	<var: #result type: #'sqInt' >
	<var: #first type: #'sqInt' >
	second := self internalPopStackInt32.
	first := self internalPopStackInt32.

	result := first // second.

	self internalPushInt32: result.

