inline primitive generated code
lowcodePrimitiveEffectiveAddress32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result offset base scale index |
	<var: #result type: #'char*' >
	<var: #offset type: #'sqInt' >
	<var: #base type: #'char*' >
	<var: #scale type: #'sqInt' >
	<var: #index type: #'sqInt' >
	offset := self internalPopStackInt32.
	scale := self internalPopStackInt32.
	index := self internalPopStackInt32.
	base := self internalPopStackPointer.

	result := base + (index*scale) + offset.

	self internalPushPointer: result.

