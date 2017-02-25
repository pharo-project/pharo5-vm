inline primitive generated code
lowcodePrimitiveOopToInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	object := self internalPopStack.

	value := self signed32BitValueOf: object.

	self internalPushInt32: value.

