inline primitive generated code
lowcodePrimitiveCallArgumentSpace
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| spaceSize |
	spaceSize := extA.

	self internalPushShadowCallStackSpace: spaceSize.

	extA := 0.

