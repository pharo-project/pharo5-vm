inline primitive generators generated code
genLowcodePushCalloutResultPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self MoveR: backEnd cResultRegister R: ReceiverResultReg.
	self ssPushNativeRegister: ReceiverResultReg.

	^ 0

