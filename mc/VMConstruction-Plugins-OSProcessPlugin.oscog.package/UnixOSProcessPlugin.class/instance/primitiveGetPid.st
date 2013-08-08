primitives - OS process access
primitiveGetPid
	"Answer the process ID of my OS process"

	| pid |
	<export: true>
	<var: 'pid' type: 'pid_t'>
	pid := self getpid.
	interpreterProxy pop: 1; pushInteger: pid