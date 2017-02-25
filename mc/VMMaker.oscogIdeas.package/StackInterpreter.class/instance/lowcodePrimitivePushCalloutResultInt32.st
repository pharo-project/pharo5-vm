inline primitive generated code
lowcodePrimitivePushCalloutResultInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'sqInt' >

	result := self lowcodeCalloutStateFetchResultInt32: lowcodeCalloutState.

	self internalPushInt32: result.

