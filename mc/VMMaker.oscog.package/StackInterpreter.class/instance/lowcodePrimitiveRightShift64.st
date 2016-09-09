inline primitive generated code
lowcodePrimitiveRightShift64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value shiftAmount result |
	<var: #value type: #'sqLong' >
	<var: #shiftAmount type: #'sqLong' >
	<var: #result type: #'sqLong' >
	shiftAmount := self internalPopStackInt64.
	value := self internalPopStackInt64.

	result := value >> shiftAmount.

	self internalPushInt64: result.

