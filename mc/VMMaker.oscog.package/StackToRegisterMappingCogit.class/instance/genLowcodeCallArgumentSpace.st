inline primitive generators generated code
genLowcodeCallArgumentSpace
	<option: #LowcodeVM>	"Lowcode instruction generator"

	"Allocate space"
	self SubCq: extA R: SPReg.
	currentCallCleanUpSize := currentCallCleanUpSize + extA.
	extA := 0.

	^ 0

