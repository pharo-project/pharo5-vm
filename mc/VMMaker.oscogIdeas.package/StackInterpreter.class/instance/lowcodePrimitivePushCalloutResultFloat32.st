inline primitive generated code
lowcodePrimitivePushCalloutResultFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'float' >

	result := self lowcodeCalloutStateFetchResultFloat32: lowcodeCalloutState.

	self internalPushFloat32: result.

