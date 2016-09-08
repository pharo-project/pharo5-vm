inline primitive generators generated code
genLowcodeCallArgumentFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssNativeTop nativeStackPopToReg: DPFPReg0.
	self ssNativePop: 1.
	self MoveRs: DPFPReg0 M32: BytesPerWord negated r: SPReg.
	self SubCq: BytesPerWord R: SPReg.
	currentCallCleanUpSize := currentCallCleanUpSize + BytesPerWord.

	^ 0

