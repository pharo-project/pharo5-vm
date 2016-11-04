inline primitive generated code
lowcodePrimitiveMalloc64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer size |
	<var: #pointer type: #'char*' >
	<var: #size type: #'sqLong' >
	size := self internalPopStackInt64.

	pointer := self malloc: size.

	self internalPushPointer: pointer.

