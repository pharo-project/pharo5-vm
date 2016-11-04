inline primitive generated code
lowcodePrimitivePointerAddConstantOffset
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| base offset result |
	<var: #base type: #'char*' >
	<var: #result type: #'char*' >
	offset := extB.
	base := self internalPopStackPointer.

	result := base + offset.

	self internalPushPointer: result.
	extB := 0.

