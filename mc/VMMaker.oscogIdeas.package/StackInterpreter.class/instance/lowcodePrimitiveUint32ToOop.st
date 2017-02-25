inline primitive generated code
lowcodePrimitiveUint32ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	value := self internalPopStackInt32.

	object := objectMemory positive32BitIntegerFor: value.

	self internalPush: object.

