primitives - fork and exec
primitiveForkSqueakWithoutSigHandler
	"Fork a child process, and continue running squeak in the child process. Leave the
	X session connected to the parent process, but close its file descriptor for the child
	process. Open a new X session for the child.

	The child should not depend on using existing connections to external resources. For
	example, the child may lose its connections to stdin, stdout, and stderr after its parent
	exits."

	| pid |
	<export: true>
	<var: 'pid' type: 'pid_t'>

	"Do not fork child if running in secure mode"
	(self sandboxSecurity == 1)
		ifTrue:
			[interpreterProxy pop: 1; pushInteger: -1]
		ifFalse:
			[pid := self forkSqueak: false.
			interpreterProxy pop: 1; pushInteger: pid]
