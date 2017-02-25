inline primitive generated code
lowcodePrimitivePushCalloutResultPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'char*' >

	result := self lowcodeCalloutStateFetchResultPointer: lowcodeCalloutState.

	self internalPushPointer: result.

