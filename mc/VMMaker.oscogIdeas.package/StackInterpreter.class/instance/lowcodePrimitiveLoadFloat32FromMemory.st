inline primitive generated code
lowcodePrimitiveLoadFloat32FromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer value |
	<var: #pointer type: #'char*' >
	<var: #value type: #'float' >
	pointer := self internalPopStackPointer.

	value := self singleFloatAtPointer: pointer.

	self internalPushFloat32: value.

