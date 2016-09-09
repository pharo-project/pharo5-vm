inline primitive ffi abi
lowcodeCalloutInt32Result: functionPointer
	<option: #LowcodeVM>
	<var: #functionPointer type: #'char*' >
	self externalizeIPandSP.
   self lowcodeCalloutState: lowcodeCalloutState callFunction: functionPointer.
   self internalizeIPandSP.
	self reloadLowcodeStateAfterCallout.
	^ self lowcodeCalloutStateFetchResultInt32: lowcodeCalloutState