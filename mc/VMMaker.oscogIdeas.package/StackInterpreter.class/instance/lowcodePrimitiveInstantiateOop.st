inline primitive generated code
lowcodePrimitiveInstantiateOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object classOop |
	<var: #object type: #'sqInt' >
	<var: #classOop type: #'sqInt' >
	classOop := self internalPopStack.

	object := objectMemory instantiateClass: classOop indexableSize: 0.

	self internalPush: object.

