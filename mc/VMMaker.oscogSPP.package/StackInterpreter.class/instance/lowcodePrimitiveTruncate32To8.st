inline primitive generated code
lowcodePrimitiveTruncate32To8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqInt' >
	<var: #result type: #'sqInt' >
	value := self internalPopStackInt32.

	result := value bitAnd: 16rFF.

	self internalPushInt32: result.

