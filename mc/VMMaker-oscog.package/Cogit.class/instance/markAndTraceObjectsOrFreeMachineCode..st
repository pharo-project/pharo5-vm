jit - api
markAndTraceObjectsOrFreeMachineCode: inFullGC
	<api>
	inFullGC
		ifTrue: [self markAndTraceOrFreeMachineCodeForFullGC]
		ifFalse: [self markAndTraceMachineCodeForIncrementalGC]