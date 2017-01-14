inline primitive generated code
lowcodePrimitiveOopToBoolean32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	object := self internalPopStack.

	value := self booleanValueOf: object.

	self internalPushInt32: value.

