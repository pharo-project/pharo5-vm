inline primitive generated code
lowcodePrimitiveStorePointerToMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| memoryPointer pointerValue |
	<var: #memoryPointer type: #'char*' >
	<var: #pointerValue type: #'char*' >
	memoryPointer := self internalPopStackPointer.
	pointerValue := self internalPopStackPointer.

	self pointerAtPointer: memoryPointer put: pointerValue.


