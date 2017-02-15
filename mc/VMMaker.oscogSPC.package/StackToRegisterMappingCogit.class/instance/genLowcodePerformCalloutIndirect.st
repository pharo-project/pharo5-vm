inline primitive generators generated code
genLowcodePerformCalloutIndirect
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	self callSwitchToCStack.
	self CallRT: ceFFICalloutTrampoline.
	self annotateBytecode: self Label.

	^ 0

