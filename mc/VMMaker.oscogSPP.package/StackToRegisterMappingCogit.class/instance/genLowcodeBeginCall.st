inline primitive generators generated code
genLowcodeBeginCall
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| alignment |
	alignment := extA.

	self beginHighLevelCall: alignment.

	extA := 0.
	^ 0

