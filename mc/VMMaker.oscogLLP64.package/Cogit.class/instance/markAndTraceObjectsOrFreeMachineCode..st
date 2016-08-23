jit - api
markAndTraceObjectsOrFreeMachineCode: inFullGC
	<api>
	<option: #SqueakV3ObjectMemory>
	inFullGC
		ifTrue: [self markAndTraceOrFreeMachineCodeForFullGC]
		ifFalse: [self markAndTraceMachineCodeForNewSpaceGC]