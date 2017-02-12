inline primitive generated code
lowcodePrimitivePushCalloutResultInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'sqLong' >

	result := self lowcodeCalloutStateFetchResultInt64: lowcodeCalloutState.

	self internalPushInt64: result.

