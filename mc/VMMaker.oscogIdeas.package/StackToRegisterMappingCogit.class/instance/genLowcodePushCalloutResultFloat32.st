inline primitive generators generated code
genLowcodePushCalloutResultFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"

	backEnd cFloatResultToRs: DPFPReg0.
	self ssPushNativeRegisterSingleFloat: DPFPReg0.

	^ 0

