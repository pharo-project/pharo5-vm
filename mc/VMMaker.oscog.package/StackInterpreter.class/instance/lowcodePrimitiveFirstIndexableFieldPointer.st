inline primitive generated code
lowcodePrimitiveFirstIndexableFieldPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object pointer |
	<var: #object type: #'sqInt' >
	<var: #pointer type: #'char*' >
	object := self internalPopStack.

	pointer := objectMemory firstIndexableField: object.

	self internalPushPointer: pointer.

