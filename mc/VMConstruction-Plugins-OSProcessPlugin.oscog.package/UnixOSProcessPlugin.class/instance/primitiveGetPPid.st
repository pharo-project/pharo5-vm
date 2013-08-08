primitives - OS process access
primitiveGetPPid
	"Answer the process ID of the parent process of my OS process"

	| ppid |
	<export: true>
	<var: 'ppid' type: 'pid_t'>
	ppid := self getppid.
	interpreterProxy pop: 1; pushInteger: ppid