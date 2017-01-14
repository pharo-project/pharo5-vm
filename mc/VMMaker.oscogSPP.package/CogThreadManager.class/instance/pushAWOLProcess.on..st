public api
pushAWOLProcess: awolProcess on: vmThread
	<var: #vmThread type: #'CogVMThread *'>
	<returnTypeC: #'CogVMThread *'>
	| cvt |
	<var: #cvt type: #'CogVMThread *'>
	cvt := vmThread.
	self assert: (cvt awolProcIndex between: 0 and: cvt awolProcLength).
	cvt awolProcIndex >= cvt awolProcLength ifTrue:
		["The realloc doesn't look like it grows but it does so by AWOLProcessesIncrement
		  entries because sizeof(CogVMThread) includes room for that many entries."
		 cvt := self cCode: 'realloc(cvt,sizeof(CogVMThread) + (sizeof(sqInt) * cvt->awolProcLength))'
					inSmalltalk: [cvt growAWOLProcesses].
		 threads at: vmThread index put: cvt.
		 cvt awolProcLength: cvt awolProcLength + AWOLProcessesIncrement].
	cvt awolProcesses at: cvt awolProcIndex put: awolProcess.
	cvt awolProcIndex: cvt awolProcIndex + 1.
	^cvt