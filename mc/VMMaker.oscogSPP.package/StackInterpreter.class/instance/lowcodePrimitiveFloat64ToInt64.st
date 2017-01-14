inline primitive generated code
lowcodePrimitiveFloat64ToInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue int64Result |
	<var: #floatValue type: #'double' >
	<var: #int64Result type: #'sqLong' >
	floatValue := self internalPopStackFloat64.

	int64Result := self cCoerce: floatValue to: 'sqLong'.

	self internalPushInt64: int64Result.

