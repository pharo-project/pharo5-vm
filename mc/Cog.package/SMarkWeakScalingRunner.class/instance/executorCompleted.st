benchmarking
executorCompleted
	runningProcessesMtx critical: [
		runningProcesses := runningProcesses - 1.
		(runningProcesses == 0) ifTrue: [
			completionSignal signal.
		]
	]