primitives - child process management
primitiveCanAccessChildProcess
	"Answer true if the OS process represented by a HANDLE can be accessed by this OS process."

	| handle exitStatus |
	<export: true>
	<var: 'handle' type: 'HANDLE'>
	<var: 'exitStatus' type: 'DWORD'>
	(handle := self handleFrom: (interpreterProxy stackObjectValue: 0)) isNil ifTrue: [^ nil].
	(((self cCode: 'GetExitCodeProcess(handle, &exitStatus)' inSmalltalk: [0]) ~= 0)
		and: [self cCode: 'exitStatus == STILL_ACTIVE' inSmalltalk: [false]])
			ifTrue: [interpreterProxy pop: 2 thenPush: interpreterProxy trueObject]
			ifFalse: [interpreterProxy pop: 2 thenPush: interpreterProxy falseObject]