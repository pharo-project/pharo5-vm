inline primitive generated code
lowcodePrimitiveFloat32ToInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'float' >
	<var: #result type: #'sqLong' >
	value := self internalPopStackFloat32.

	result := self cCoerce: value to: 'sqLong'.

	self internalPushInt64: result.

