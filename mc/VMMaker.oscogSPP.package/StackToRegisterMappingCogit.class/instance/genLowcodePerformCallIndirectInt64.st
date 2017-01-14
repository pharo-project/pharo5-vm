inline primitive generators generated code
genLowcodePerformCallIndirectInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	self callSwitchToCStack.
	self CallRT: ceFFICalloutTrampoline.
	BytesPerWord = 4 ifTrue: [
	self MoveR: backEnd cResultRegisterLow R: ReceiverResultReg.
	self MoveR: backEnd cResultRegisterHigh R: Arg0Reg.
	self ssPushNativeRegister: ReceiverResultReg secondRegister: Arg0Reg.
	] ifFalse: [
	self MoveR: backEnd cResultRegister R: ReceiverResultReg.
	self ssPushNativeRegister: ReceiverResultReg.
	].

	^ 0

