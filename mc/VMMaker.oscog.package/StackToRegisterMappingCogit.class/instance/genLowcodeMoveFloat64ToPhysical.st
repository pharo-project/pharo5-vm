inline primitive generators generated code
genLowcodeMoveFloat64ToPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssNativeTop nativeStackPopToReg: extA.
	self ssNativePop: 1.
	currentCallCleanUpSize := currentCallCleanUpSize + 8.
	extA := 0.

	^ 0

