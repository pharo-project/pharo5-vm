inline primitive generated code
lowcodePrimitiveLoadInt32FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'sqInt' >
	pointer := self internalPopStackPointer.

	value := self int32AtPointer: pointer.

	self internalPushInt32: value.

