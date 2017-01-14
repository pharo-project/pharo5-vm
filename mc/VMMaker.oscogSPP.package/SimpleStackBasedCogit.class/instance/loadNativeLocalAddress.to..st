bytecode generator support
loadNativeLocalAddress: baseOffset to: reg
	<option: #LowcodeVM>
	self MoveMw: self frameOffsetOfNativeFramePointer r: FPReg R: reg.
	self AddCq: baseOffset - 1 R: reg.