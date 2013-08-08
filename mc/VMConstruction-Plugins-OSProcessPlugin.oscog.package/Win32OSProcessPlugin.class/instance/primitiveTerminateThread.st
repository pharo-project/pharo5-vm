primitives - child process management
primitiveTerminateThread
	"Kill the thread. No cleanup is performed, so use with caution for a thread which
	is (for example) manipulating a mutex. Answer true for success, else false."

	| handle |
	<export: true>
	<var: 'handle' type: 'HANDLE'>
	<var: 'exitStatus' type: 'DWORD'>
	(handle := self handleFrom: (interpreterProxy stackObjectValue: 0)) isNil ifTrue: [^ nil].
	(self cCode: 'TerminateThread(handle, 0)' inSmalltalk: [false])
		ifTrue: [^ interpreterProxy pop: 2 thenPush: interpreterProxy trueObject]
		ifFalse: [^ interpreterProxy pop: 2 thenPush: interpreterProxy falseObject]
