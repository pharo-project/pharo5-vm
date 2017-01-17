inline primitive generated code
lowcodePrimitiveInstantiateIndexableOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| indexableSize object classOop |
	<var: #object type: #'sqInt' >
	<var: #classOop type: #'sqInt' >
	indexableSize := extA.
	classOop := self internalPopStack.

	object := objectMemory instantiateClass: classOop indexableSize: indexableSize.

	self internalPush: object.
	extA := 0.

