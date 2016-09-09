inline primitive generated code
lowcodePrimitiveCallArgumentInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value |
	<var: #value type: #'sqInt' >
	value := self internalPopStackInt32.

	self internalPushShadowCallStackInt32: value.


