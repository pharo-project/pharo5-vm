public api
vmThreadAt: index
	<returnTypeC: #'CogVMThread *'>
	self assert: (index between: 1 and: numThreads).
	^threads at: index