inline primitive generated code
lowcodePrimitiveTruncate32To16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqInt' >
	<var: #result type: #'sqInt' >
	value := self internalPopStackInt32.

	result := value bitAnd: 16rFFFF.

	self internalPushInt32: result.

