primitives - OS process access
primitiveGetPid
	"Answer the process ID of my OS process"

	| pid pidOop |
	<export: true>
	<var: 'pid' type: 'DWORD'>
	pid := self GetCurrentProcessId.
	pidOop := interpreterProxy positive32BitIntegerFor: pid.
	interpreterProxy pop: 1 thenPush: pidOop
