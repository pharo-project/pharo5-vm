inline primitive generated code
lowcodePrimitiveCheckSessionIdentifier
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| expectedSession value |
	<var: #value type: #'sqInt' >
	expectedSession := extA.

	value := (expectedSession = self getThisSessionID) ifTrue: [1] ifFalse: [0].

	self internalPushInt32: value.
	extA := 0.

