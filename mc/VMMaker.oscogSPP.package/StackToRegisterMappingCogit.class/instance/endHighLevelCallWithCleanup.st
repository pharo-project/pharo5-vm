inline ffi
endHighLevelCallWithCleanup
	<option: #LowcodeVM>
	currentCallCleanUpSize > 0 ifTrue: [
		self AddCq: currentCallCleanUpSize R: SPReg
	].
   self callSwitchToSmalltalkStack.
