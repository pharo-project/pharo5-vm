inline primitive generators generated code
genLowcodePerformCallFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self callSwitchToCStack.
	self MoveCw: extA R: TempReg.
	self CallRT: ceFFICalloutTrampoline.
	backEnd cFloatResultToRs: DPFPReg0.
	self ssPushNativeRegisterSingleFloat: DPFPReg0.
	extA := 0.

	^ 0

