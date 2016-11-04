inline primitive generated code
lowcodePrimitiveCallArgumentPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerValue |
	<var: #pointerValue type: #'char*' >
	pointerValue := self internalPopStackPointer.

	self internalPushShadowCallStackPointer: pointerValue.


