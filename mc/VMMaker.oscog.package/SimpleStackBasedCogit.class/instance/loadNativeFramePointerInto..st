bytecode generator support
loadNativeFramePointerInto: reg
	<option: #LowcodeVM>
	self MoveMw: self frameOffsetOfNativeFramePointer r: FPReg R: reg