inline primitive generated code
lowcodePrimitiveLoadInt64FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'sqLong' >
	pointer := self internalPopStackPointer.

	value := self int64AtPointer: pointer.

	self internalPushInt64: value.

