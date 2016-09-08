inline primitive generated code
lowcodePrimitiveUint64ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqLong' >
	value := self internalPopStackInt64.

	object := self positive64BitIntegerFor: value.

	self internalPush: object.

