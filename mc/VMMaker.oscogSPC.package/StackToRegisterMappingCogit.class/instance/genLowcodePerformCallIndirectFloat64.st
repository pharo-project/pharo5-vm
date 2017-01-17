inline primitive generators generated code
genLowcodePerformCallIndirectFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	self callSwitchToCStack.
	self CallRT: ceFFICalloutTrampoline.
	backEnd cFloatResultToRd: DPFPReg0.
	self ssPushNativeRegisterDoubleFloat: DPFPReg0.

	^ 0

