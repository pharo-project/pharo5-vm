inline primitive generators generated code
genLowcodePushCalloutResultFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"

	backEnd cFloatResultToRd: DPFPReg0.
	self ssPushNativeRegisterDoubleFloat: DPFPReg0.

	^ 0

