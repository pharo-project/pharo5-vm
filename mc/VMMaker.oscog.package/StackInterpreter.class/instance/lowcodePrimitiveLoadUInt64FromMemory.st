inline primitive generated code
lowcodePrimitiveLoadUInt64FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'sqLong' >
	pointer := self internalPopStackPointer.

	value := self uint64AtPointer: pointer.

	self internalPushInt64: value.

