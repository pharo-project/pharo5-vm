inline primitive generated code
lowcodePrimitiveMalloc32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer size |
	<var: #pointer type: #'char*' >
	<var: #size type: #'sqInt' >
	size := self internalPopStackInt32.

	pointer := self malloc: size.

	self internalPushPointer: pointer.

