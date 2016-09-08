inline primitive generated code
lowcodePrimitivePointerAddOffset64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| base offset result |
	<var: #base type: #'char*' >
	<var: #offset type: #'sqLong' >
	<var: #result type: #'char*' >
	offset := self internalPopStackInt64.
	base := self internalPopStackPointer.

	result := base + offset.

	self internalPushPointer: result.

