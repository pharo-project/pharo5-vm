inline primitive generators generated code
genLowcodeCallPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID |
	registerID := extA.

	self CallR: registerID.

	extA := 0.
	^ 0

