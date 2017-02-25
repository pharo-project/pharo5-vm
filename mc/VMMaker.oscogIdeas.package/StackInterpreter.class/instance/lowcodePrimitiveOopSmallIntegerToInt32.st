inline primitive generated code
lowcodePrimitiveOopSmallIntegerToInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	object := self internalPopStack.

	value := objectMemory integerValueOf: object.

	self internalPushInt32: value.

