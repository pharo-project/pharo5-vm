deprecated
primitiveCommand
	"Create a process to run commandString. Answer an Array formed from the
	PROCESS_INFORMATION structure for the new process. The caller is expected
	to close the process and thread handles when they are no longer needed.
	The result array contains hProcess, hThread, dwProcessId, dwThreadId.

	This primitive has been replaced by #primitiveCommandWithInputOutputError,
	and will be removed in future versions of OSProcess."

	| cStringPtr commandString startUp procInfo processInformation |
	<export: true>
	<var: 'cStringPtr' type: #'void *'>
	<var: 'startUp' type: 'STARTUPINFO'>
	<var: 'procInfo' type: 'PROCESS_INFORMATION'>

	commandString := interpreterProxy stackObjectValue: 0.
	cStringPtr := self cStringFromString: commandString.

	self cCode: 'GetStartupInfo (&startUp)'.
	self cCode: 'startUp.hStdInput = GetStdHandle(STD_INPUT_HANDLE)'.
	self cCode: 'startUp.hStdOutput = GetStdHandle(STD_OUTPUT_HANDLE)'.
	self cCode: 'startUp.hStdError = GetStdHandle(STD_ERROR_HANDLE)'.
	(self cCode:  'CreateProcess(NULL, cStringPtr, NULL, NULL, TRUE, NORMAL_PRIORITY_CLASS, NULL, NULL, &startUp, &procInfo)')
		ifFalse: [^ interpreterProxy primitiveFail].

	interpreterProxy pushRemappableOop: (interpreterProxy positive32BitIntegerFor: (self cCode: 'procInfo.dwThreadId')).
	interpreterProxy pushRemappableOop: (interpreterProxy positive32BitIntegerFor: (self cCode: 'procInfo.dwProcessId')).
	interpreterProxy pushRemappableOop: (self handleObjectFrom: (self cCode: 'procInfo.hThread')).
	interpreterProxy pushRemappableOop: (self handleObjectFrom: (self cCode: 'procInfo.hProcess')).
	processInformation := interpreterProxy
		instantiateClass: interpreterProxy classArray
		indexableSize: 4.
	interpreterProxy
		storePointer: 0
		ofObject: processInformation
		withValue: interpreterProxy popRemappableOop.
	interpreterProxy
		storePointer: 1
		ofObject: processInformation
		withValue: interpreterProxy popRemappableOop.
	interpreterProxy
		storePointer: 2
		ofObject: processInformation
		withValue: interpreterProxy popRemappableOop.
	interpreterProxy
		storePointer: 3
		ofObject: processInformation
		withValue: interpreterProxy popRemappableOop.
	interpreterProxy pop: 2; push: processInformation
