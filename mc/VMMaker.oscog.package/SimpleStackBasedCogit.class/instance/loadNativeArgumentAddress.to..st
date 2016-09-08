bytecode generator support
loadNativeArgumentAddress: baseOffset to: reg
	<option: #LowcodeVM>
	self MoveMw: self frameOffsetOfPreviousNativeStackPointer r: FPReg R: reg.
	self AddCq: baseOffset - 1 R: reg.