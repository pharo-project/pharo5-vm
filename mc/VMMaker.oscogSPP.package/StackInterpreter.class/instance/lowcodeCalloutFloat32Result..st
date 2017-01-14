inline primitive ffi abi
lowcodeCalloutFloat32Result: functionPointer
	<option: #LowcodeVM>
	<var: #functionPointer type: #'char*' >
	self externalizeIPandSP.
   self lowcodeCalloutState: lowcodeCalloutState callFunction: functionPointer.
   self internalizeIPandSP.
	self reloadLowcodeStateAfterCallout.
	^ self lowcodeCalloutStateFetchResultFloat32: lowcodeCalloutState