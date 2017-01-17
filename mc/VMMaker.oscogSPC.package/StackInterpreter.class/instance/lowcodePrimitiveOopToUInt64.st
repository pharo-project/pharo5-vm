inline primitive generated code
lowcodePrimitiveOopToUInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqLong' >
	object := self internalPopStack.

	value := self positive64BitValueOf: object.

	self internalPushInt64: value.

