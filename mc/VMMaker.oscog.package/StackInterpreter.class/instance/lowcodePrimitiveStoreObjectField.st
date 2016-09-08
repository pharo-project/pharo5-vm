inline primitive generated code
lowcodePrimitiveStoreObjectField
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| fieldIndex object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	fieldIndex := extA.
	value := self internalPopStack.
	object := self internalPopStack.

	objectMemory storePointer: fieldIndex ofObject: object withValue: value.

	extA := 0.

