inline primitive generators generated code
genLowcodePerformCallIndirectStructure
	<option: #LowcodeVM>	"Lowcode instruction generator"

	"Push the result space"
	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	self PushR: TempReg.
	"Fetch the function pointer"
	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	"Call the function"
	self callSwitchToCStack.
	self CallRT: ceFFICalloutTrampoline.
	self annotateBytecode: self Label.
	"Fetch the result"
	self MoveR: backEnd cResultRegister R: ReceiverResultReg.
	self ssPushNativeRegister: ReceiverResultReg.
	extA := 0.

	^ 0

