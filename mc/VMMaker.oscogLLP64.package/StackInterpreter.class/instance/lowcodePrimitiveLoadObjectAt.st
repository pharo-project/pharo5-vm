inline primitive generated code
lowcodePrimitiveLoadObjectAt
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| fieldIndex object fieldValue |
	<var: #fieldIndex type: #'sqInt' >
	<var: #object type: #'sqInt' >
	<var: #fieldValue type: #'sqInt' >
	fieldIndex := self internalPopStackInt32.
	object := self internalPopStack.

	fieldValue := objectMemory fetchPointer: fieldIndex ofObject: object.

	self internalPush: fieldValue.

