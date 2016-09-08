inline primitive generated code
lowcodePrimitiveLoadObjectField
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| fieldIndex object fieldValue |
	<var: #object type: #'sqInt' >
	<var: #fieldValue type: #'sqInt' >
	fieldIndex := extA.
	object := self internalPopStack.

	fieldValue := self fetchPointer: fieldIndex ofObject: object.

	self internalPush: fieldValue.
	extA := 0.

