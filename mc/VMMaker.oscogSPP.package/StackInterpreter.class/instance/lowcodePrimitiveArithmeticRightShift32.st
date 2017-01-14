inline primitive generated code
lowcodePrimitiveArithmeticRightShift32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value shiftAmount result |
	<var: #value type: #'sqInt' >
	<var: #shiftAmount type: #'sqInt' >
	<var: #result type: #'sqInt' >
	shiftAmount := self internalPopStackInt32.
	value := self internalPopStackInt32.

	result := value >> shiftAmount.

	self internalPushInt32: result.

