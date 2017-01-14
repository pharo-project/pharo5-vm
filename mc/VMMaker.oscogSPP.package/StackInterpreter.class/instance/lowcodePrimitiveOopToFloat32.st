inline primitive generated code
lowcodePrimitiveOopToFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| object value |
	<var: #object type: #'sqInt' >
	<var: #value type: #'float' >
	object := self internalPopStack.

	value := objectMemory floatValueOf: object.

	self internalPushFloat32: value.

