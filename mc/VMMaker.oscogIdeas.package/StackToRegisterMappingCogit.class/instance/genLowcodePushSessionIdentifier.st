inline primitive generators generated code
genLowcodePushSessionIdentifier
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssPushNativeConstantInt32: coInterpreter getThisSessionID.

	^ 0

