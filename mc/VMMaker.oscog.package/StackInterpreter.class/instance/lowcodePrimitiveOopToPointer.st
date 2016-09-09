inline primitive generated code
lowcodePrimitiveOopToPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object pointer |
	<var: #object type: #'sqInt' >
	<var: #pointer type: #'char*' >
	object := self internalPopStack.

	pointer := self pointerAtPointer: (objectMemory firstIndexableField: object).

	self internalPushPointer: pointer.

