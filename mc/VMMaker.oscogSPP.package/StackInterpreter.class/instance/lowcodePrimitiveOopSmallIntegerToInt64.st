inline primitive generated code
lowcodePrimitiveOopSmallIntegerToInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqLong' >
	object := self internalPopStack.

	value := objectMemory integerValueOf: object.

	self internalPushInt64: value.

