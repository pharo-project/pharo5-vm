inline primitive generators generated code
genLowcodeCallArgumentStructure
	<option: #LowcodeVM>	"Lowcode instruction generator"

	"Fetch the pointer"
	self ssNativeTop nativeStackPopToReg: TempReg.
	self ssNativePop: 1.
	"Allocate space"
	self SubCq: extA R: SPReg.
	currentCallCleanUpSize := currentCallCleanUpSize + extA.
	"Copy the structure"
	backEnd genMemCopy: TempReg to: SPReg constantSize: extA.
	extA := 0.

	^ 0

