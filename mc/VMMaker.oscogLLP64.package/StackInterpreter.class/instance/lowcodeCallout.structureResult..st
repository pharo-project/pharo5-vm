inline primitive ffi abi
lowcodeCallout: functionPointer structureResult: resultPointer
	<option: #LowcodeVM>
	<var: #functionPointer type: #'char*' >
	<var: #resultPointer type: #'char*' >
	self internalPushShadowCallStackPointer: resultPointer.
	self externalizeIPandSP.
   self lowcodeCalloutState: lowcodeCalloutState callFunction: functionPointer.
   self internalizeIPandSP.
	self reloadLowcodeStateAfterCallout.
	^ self lowcodeCalloutStateFetchResultStructure: lowcodeCalloutState