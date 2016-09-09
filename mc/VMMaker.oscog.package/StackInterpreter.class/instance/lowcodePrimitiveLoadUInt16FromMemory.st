inline primitive generated code
lowcodePrimitiveLoadUInt16FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'sqInt' >
	pointer := self internalPopStackPointer.

	value := self uint16AtPointer: pointer.

	self internalPushInt32: value.

