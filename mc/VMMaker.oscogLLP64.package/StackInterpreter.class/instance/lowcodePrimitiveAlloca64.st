inline primitive generated code
lowcodePrimitiveAlloca64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer size |
	<var: #pointer type: #'char*' >
	<var: #size type: #'sqLong' >
	size := self internalPopStackInt64.

	nativeStackPointer := nativeStackPointer - size.
	pointer := nativeStackPointer.

	self internalPushPointer: pointer.

