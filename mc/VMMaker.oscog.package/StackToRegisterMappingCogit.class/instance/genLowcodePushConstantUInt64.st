inline primitive generators generated code
genLowcodePushConstantUInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| constant |
	constant := extA.

	self ssPushNativeConstantInt64: constant.

	extA := 0.
	^ 0

