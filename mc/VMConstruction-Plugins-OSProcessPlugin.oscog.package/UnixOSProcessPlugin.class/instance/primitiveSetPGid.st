primitives - OS process access
primitiveSetPGid
	"Set the process group ID of the process identified by pid to a new process
	group ID."

	| pid pgid |
	<export: true>
	<var: 'pid' type: 'pid_t'>
	<var: 'pgid' type: 'pid_t'>
	pid := interpreterProxy stackIntegerValue: 1.
	pgid := interpreterProxy stackIntegerValue: 0.
	(self set: pid pgid: pgid) == -1 ifTrue: [^ interpreterProxy primitiveFail].
	interpreterProxy pop: 2
