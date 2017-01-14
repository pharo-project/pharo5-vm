inline primitive generators generated code
genLowcodePerformCallIndirectPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	self callSwitchToCStack.
	self CallRT: ceFFICalloutTrampoline.
	self MoveR: backEnd cResultRegister R: ReceiverResultReg.
	self ssPushNativeRegister: ReceiverResultReg.

	^ 0

