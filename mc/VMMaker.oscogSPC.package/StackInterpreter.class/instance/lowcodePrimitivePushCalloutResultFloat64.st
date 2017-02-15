inline primitive generated code
lowcodePrimitivePushCalloutResultFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'double' >

	result := self lowcodeCalloutStateFetchResultFloat64: lowcodeCalloutState.

	self internalPushFloat64: result.

