inline primitive generated code
lowcodePrimitiveLoadPointerFromMemory
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerResult pointer |
	<var: #pointerResult type: #'char*' >
	<var: #pointer type: #'char*' >
	pointer := self internalPopStackPointer.

	pointerResult := self pointerAtPointer: pointer.

	self internalPushPointer: pointerResult.

