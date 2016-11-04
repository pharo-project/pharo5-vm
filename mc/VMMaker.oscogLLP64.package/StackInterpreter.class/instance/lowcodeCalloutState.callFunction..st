inline primitive ffi abi
lowcodeCalloutState: calloutState callFunction: functionPointer
	<option: #LowcodeVM>
	self lowcodeCalloutState: calloutState stackPointer: shadowCallStackPointer stackSize: (self cCoerce: lowcodeCalloutState to: #'char*') - shadowCallStackPointer callFunction: functionPointer
