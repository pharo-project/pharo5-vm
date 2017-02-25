inline primitive generated code
lowcodePrimitiveCallArgumentFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| argumentValue |
	<var: #argumentValue type: #'float' >
	argumentValue := self internalPopStackFloat32.

	self internalPushShadowCallStackFloat32: argumentValue.


