inline primitive generated code
lowcodePrimitiveFloat64ToUInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue int64Result |
	<var: #floatValue type: #'double' >
	<var: #int64Result type: #'sqInt' >
	floatValue := self internalPopStackFloat64.

	int64Result := self cCoerce: floatValue to: 'uint32_t'.

	self internalPushInt32: int64Result.

