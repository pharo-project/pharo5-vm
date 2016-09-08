public api
popAWOLProcess: vmThread
	<var: #vmThread type: #'CogVMThread *'>
	self assert: vmThread awolProcIndex > 0.
	^vmThread awolProcesses at: (vmThread awolProcIndex: vmThread awolProcIndex - 1)