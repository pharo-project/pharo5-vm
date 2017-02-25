inline primitive ffi abi
lowcodeDoCallout: functionPointer
	<option: #LowcodeVM>
	<var: #functionPointer type: #'char*' >
	self undoFetchNextBytecode.
	self externalizeIPandSP.
	self lowcodeCalloutState: lowcodeCalloutState callFunction: functionPointer.
	instructionPointer = cogit ceReturnToInterpreterPC ifTrue: [
		instructionPointer := self iframeSavedIP: framePointer.
	].
	self internalizeIPandSP.
	self reloadLowcodeStateAfterCallout.
	self fetchNextBytecode.
	^ self lowcodeCalloutStateFetchResultFloat32: lowcodeCalloutState