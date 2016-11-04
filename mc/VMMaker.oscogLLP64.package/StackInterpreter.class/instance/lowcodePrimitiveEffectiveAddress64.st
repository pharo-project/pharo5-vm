inline primitive generated code
lowcodePrimitiveEffectiveAddress64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result offset base scale index |
	<var: #result type: #'char*' >
	<var: #offset type: #'sqLong' >
	<var: #base type: #'char*' >
	<var: #scale type: #'sqLong' >
	<var: #index type: #'sqLong' >
	offset := self internalPopStackInt64.
	scale := self internalPopStackInt64.
	index := self internalPopStackInt64.
	base := self internalPopStackPointer.

	result := base + (index*scale) + offset.

	self internalPushPointer: result.

