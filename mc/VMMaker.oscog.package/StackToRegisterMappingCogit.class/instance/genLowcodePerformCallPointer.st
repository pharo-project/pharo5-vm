inline primitive generators generated code
genLowcodePerformCallPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self callSwitchToCStack.
	self MoveCw: extA R: TempReg.
	self CallRT: ceFFICalloutTrampoline.
	self MoveR: backEnd cResultRegister R: ReceiverResultReg.
	self ssPushNativeRegister: ReceiverResultReg.
	extA := 0.

	^ 0

