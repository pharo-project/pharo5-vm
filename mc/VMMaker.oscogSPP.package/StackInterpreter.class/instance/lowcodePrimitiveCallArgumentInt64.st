inline primitive generated code
lowcodePrimitiveCallArgumentInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value |
	<var: #value type: #'sqLong' >
	value := self internalPopStackInt64.

	self internalPushShadowCallStackInt64: value.


