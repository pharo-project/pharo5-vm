inline primitive generators generated code
genLowcodeMovePointerToPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self ssNativeTop nativeStackPopToReg: extA.
	self ssNativePop: 1.
	currentCallCleanUpSize := currentCallCleanUpSize + BytesPerWord.
	extA := 0.

	^ 0

