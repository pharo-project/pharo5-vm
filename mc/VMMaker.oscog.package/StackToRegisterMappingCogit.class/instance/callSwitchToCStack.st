inline ffi
callSwitchToCStack
	<option: #LowcodeVM>
	self MoveAw: self cFramePointerAddress R: FPReg.
	^0