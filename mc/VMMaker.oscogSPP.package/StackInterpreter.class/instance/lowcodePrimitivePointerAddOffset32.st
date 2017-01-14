inline primitive generated code
lowcodePrimitivePointerAddOffset32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| base offset result |
	<var: #base type: #'char*' >
	<var: #offset type: #'sqInt' >
	<var: #result type: #'char*' >
	offset := self internalPopStackInt32.
	base := self internalPopStackPointer.

	result := base + offset.

	self internalPushPointer: result.

