thread set
unusedThreadInfo
	"Answer a pointer to an unused CogVMThread, growing the sequence if necessary."
	<returnTypeC: #'CogVMThread *'>
	| vmThread index |
	<var: #vmThread type: #'CogVMThread *'>
	1 to: numThreads do:
		[:i|
		vmThread := threads at: i.
		self assert: vmThread index = i.
		vmThread state isNil ifTrue:
			[^vmThread]].
	index := numThreads + 1.
	(self growThreadInfosToAtLeast: numThreads + numThreadsIncrement) ifFalse:
		[^nil].
	^threads at: index