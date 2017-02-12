inline primitive generators generated code
genLowcodePerformCallout
	<option: #LowcodeVM>	"Lowcode instruction generator"

	self callSwitchToCStack.
	self MoveCw: extA R: TempReg.
	self CallRT: ceFFICalloutTrampoline.
	self annotateBytecode: self Label.
	extA := 0.

	^ 0

