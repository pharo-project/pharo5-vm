inline primitive generated code
lowcodePrimitiveStoreObjectFieldAt
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| fieldIndex object value |
	<var: #fieldIndex type: #'sqInt' >
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	value := self internalPopStack.
	fieldIndex := self internalPopStackInt32.
	object := self internalPopStack.

	objectMemory storePointer: fieldIndex ofObject: object withValue: value.


