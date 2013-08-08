primitives - child process management
primitiveGetExitStatusForHandle
	"Answer the exit status for the process represented by a HANDLE. Fail if
	the process is still active, or if the GetExitCodeProcess call fails."

	| handle exitStatus |
	<export: true>
	<var: 'handle' type: 'HANDLE'>
	<var: 'exitStatus' type: 'DWORD'>
	(handle := self handleFrom: (interpreterProxy stackObjectValue: 0)) isNil ifTrue: [^ nil].
	((self cCode: 'GetExitCodeProcess(handle, &exitStatus)' inSmalltalk: [0]) ~= 0)
		ifTrue:
			[(self cCode: 'exitStatus == STILL_ACTIVE' inSmalltalk: [false]) ifTrue:
				["Child process is still active, fail the primitive"
				^ interpreterProxy primitiveFail].
			interpreterProxy
				pop: 2
				thenPush: (interpreterProxy positive32BitIntegerFor: exitStatus)]
		ifFalse:
			[^ interpreterProxy primitiveFail]
