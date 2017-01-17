inline primitive ffi abi
lowcodeCalloutPointerResult: functionPointer
	<option: #LowcodeVM>
	<var: #functionPointer type: #'char*' >
	self externalizeIPandSP.
   self lowcodeCalloutState: lowcodeCalloutState callFunction: functionPointer.
   self internalizeIPandSP.
	self reloadLowcodeStateAfterCallout.
	^ self lowcodeCalloutStateFetchResultPointer: lowcodeCalloutState