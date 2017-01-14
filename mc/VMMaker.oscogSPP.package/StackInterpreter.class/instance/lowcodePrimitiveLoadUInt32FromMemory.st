inline primitive generated code
lowcodePrimitiveLoadUInt32FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'sqInt' >
	pointer := self internalPopStackPointer.

	value := self uint32AtPointer: pointer.

	self internalPushInt32: value.

