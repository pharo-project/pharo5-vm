inline primitive generated code
lowcodePrimitiveAlloca32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer size |
	<var: #pointer type: #'char*' >
	<var: #size type: #'sqInt' >
	size := self internalPopStackInt32.

	nativeStackPointer := self cCoerce:
	((self cCoerce: nativeStackPointer - size to: 'size_t') bitAnd: -16)
	to: 'char*'.
	pointer := nativeStackPointer.

	self internalPushPointer: pointer.

