inline primitive generators generated code
genLowcodePerformCallIndirectFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	self callSwitchToCStack.
	self CallRT: ceFFICalloutTrampoline.
	backEnd cFloatResultToRs: DPFPReg0.
	self ssPushNativeRegisterSingleFloat: DPFPReg0.

	^ 0

