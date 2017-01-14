inline primitive generated code
lowcodePrimitiveInt64ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqLong' >
	value := self internalPopStackInt64.

	object := objectMemory signed64BitIntegerFor: value.

	self internalPush: object.

