inline primitive generated code
lowcodePrimitivePointerToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer object pointerClassLiteral |
	<var: #pointer type: #'char*' >
	<var: #object type: #'sqInt' >
	pointerClassLiteral := self literal: extA.
	pointer := self internalPopStackPointer.

	object := objectMemory instantiateClass: pointerClassLiteral indexableSize: BytesPerWord.
	self pointerAtPointer: (objectMemory firstIndexableField: object) put: pointer.

	self internalPush: object.
	extA := 0.

