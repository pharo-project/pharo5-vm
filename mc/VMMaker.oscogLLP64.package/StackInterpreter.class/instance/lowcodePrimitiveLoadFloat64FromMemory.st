inline primitive generated code
lowcodePrimitiveLoadFloat64FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'double' >
	pointer := self internalPopStackPointer.

	value := self floatAtPointer: pointer.

	self internalPushFloat64: value.

