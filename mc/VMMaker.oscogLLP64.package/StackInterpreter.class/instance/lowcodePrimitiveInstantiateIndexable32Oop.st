inline primitive generated code
lowcodePrimitiveInstantiateIndexable32Oop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| indexableSize object classOop |
	<var: #indexableSize type: #'sqInt' >
	<var: #object type: #'sqInt' >
	<var: #classOop type: #'sqInt' >
	indexableSize := self internalPopStackInt32.
	classOop := self internalPopStack.

	object := objectMemory instantiateClass: classOop indexableSize: indexableSize.

	self internalPush: object.

