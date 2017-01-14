inline primitive generated code
lowcodePrimitivePushOneFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'float' >

	result := 1.0.

	self internalPushFloat32: result.

