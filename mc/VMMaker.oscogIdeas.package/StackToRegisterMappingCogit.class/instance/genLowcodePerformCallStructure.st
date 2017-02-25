inline primitive generators generated code
genLowcodePerformCallStructure
	<option: #LowcodeVM>	"Lowcode instruction generator"

	"Push the result space"
	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	self PushR: TempReg.
	"Call the function"
	self callSwitchToCStack.
	self MoveCw: extA R: TempReg.
	self CallRT: ceFFICalloutTrampoline.
	self annotateBytecode: self Label.
	"Fetch the result"
	self MoveR: backEnd cResultRegister R: ReceiverResultReg.
	self ssPushNativeRegister: ReceiverResultReg.
	extA := 0.
	extB := 0.
	numExtB := 0.

	^ 0

