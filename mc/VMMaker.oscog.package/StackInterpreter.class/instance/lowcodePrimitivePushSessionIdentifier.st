inline primitive generated code
lowcodePrimitivePushSessionIdentifier
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value |
	<var: #value type: #'sqInt' >

	value := self getThisSessionID.

	self internalPushInt32: value.

