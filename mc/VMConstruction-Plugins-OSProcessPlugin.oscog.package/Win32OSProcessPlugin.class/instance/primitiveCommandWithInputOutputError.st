primitives - process creation
primitiveCommandWithInputOutputError
	"Create a process to run commandString, using the specified input, output,
	and error streams. If any of the input, output, or error streams is nil, then
	the current values of these handles in this OS process will be passed to the
	new process. Answer an Array formed from the PROCESS_INFORMATION
	structure for the new process. The caller is expected to close the process and
	thread handles when they are no longer needed. The result array contains
	hProcess, hThread, dwProcessId, dwThreadId."

	| cStringPtr commandString startUp procInfo processInformation stdErr stdOut stdIn
	inputHandle outputHandle errorHandle |
	<export: true>
	<var: 'cStringPtr' type: #'void *'>
	<var: 'startUp' type: 'STARTUPINFO'>
	<var: 'procInfo' type: 'PROCESS_INFORMATION'>
	<var: 'inputHandle' type: 'HANDLE'>
	<var: 'outputHandle' type: 'HANDLE'>
	<var: 'errorHandle' type: 'HANDLE'>
	stdErr := interpreterProxy stackObjectValue: 0.
	stdOut := interpreterProxy stackObjectValue: 1.
	stdIn := interpreterProxy stackObjectValue: 2.
	commandString := interpreterProxy stackObjectValue: 3.
	cStringPtr := self cStringFromString: commandString.
	(stdIn = interpreterProxy nilObject)
		ifTrue: [inputHandle := self stdInputHandle]
		ifFalse: [inputHandle := self handleFromSQFile: stdIn].
	(stdOut = interpreterProxy nilObject)
		ifTrue: [outputHandle := self stdOutputHandle]
		ifFalse: [outputHandle := self handleFromSQFile: stdOut].
	(stdErr = interpreterProxy nilObject)
		ifTrue: [errorHandle := self stdErrorHandle]
		ifFalse: [errorHandle := self handleFromSQFile: stdErr].
	self cCode: 'GetStartupInfo (&startUp)'.
	self cCode: 'startUp.hStdInput = inputHandle'.
	self cCode: 'startUp.hStdOutput = outputHandle'.
	self cCode: 'startUp.hStdError = errorHandle'.

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
	interpreterProxy pop: 5; push: processInformation
