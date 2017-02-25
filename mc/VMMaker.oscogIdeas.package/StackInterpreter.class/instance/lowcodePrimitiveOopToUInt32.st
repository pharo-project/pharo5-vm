inline primitive generated code
lowcodePrimitiveOopToUInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'sqInt' >
	object := self internalPopStack.

	value := self positive32BitValueOf: object.

	self internalPushInt32: value.

