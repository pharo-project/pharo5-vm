inline primitive generated code
lowcodePrimitiveOopToFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'double' >
	object := self internalPopStack.

	value := objectMemory floatValueOf: object.

	self internalPushFloat64: value.

