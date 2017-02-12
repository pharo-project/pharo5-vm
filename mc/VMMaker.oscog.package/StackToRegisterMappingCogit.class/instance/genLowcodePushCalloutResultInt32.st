inline primitive generators generated code
genLowcodePushCalloutResultInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self MoveR: backEnd cResultRegister R: ReceiverResultReg.
	self ssPushNativeRegister: ReceiverResultReg.

	^ 0

