inline primitive generated code
lowcodePrimitiveFloat32ToOop
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| singleFloatValue object |
	<var: #singleFloatValue type: #'float' >
	<var: #object type: #'sqInt' >
	singleFloatValue := self internalPopStackFloat32.

	object := objectMemory floatObjectOf: singleFloatValue.

	self internalPush: object.

