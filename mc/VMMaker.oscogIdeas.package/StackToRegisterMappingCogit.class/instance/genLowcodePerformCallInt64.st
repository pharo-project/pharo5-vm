inline primitive generators generated code
genLowcodePerformCallInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self callSwitchToCStack.
	self MoveCw: extA R: TempReg.
	self CallRT: ceFFICalloutTrampoline.
	self annotateBytecode: self Label.
	BytesPerWord = 4 ifTrue: [
	self MoveR: backEnd cResultRegisterLow R: ReceiverResultReg.
	self MoveR: backEnd cResultRegisterHigh R: Arg0Reg.
	self ssPushNativeRegister: ReceiverResultReg secondRegister: Arg0Reg.
	] ifFalse: [
	self MoveR: backEnd cResultRegister R: ReceiverResultReg.
	self ssPushNativeRegister: ReceiverResultReg.
	].
	extA := 0.

	^ 0

