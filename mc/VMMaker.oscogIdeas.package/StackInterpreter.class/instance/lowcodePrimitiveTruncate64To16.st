inline primitive generated code
lowcodePrimitiveTruncate64To16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'sqInt' >
	value := self internalPopStackInt64.

	result := value bitAnd: 16rFFFF.

	self internalPushInt32: result.

