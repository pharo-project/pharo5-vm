primitives - OS process access
primitiveGetPGid
	"Answer the process group ID of the process identified by pid"

	| pid pgid |
	<export: true>
	<var: 'pid' type: 'pid_t'>
	<var: 'pgid' type: 'pid_t'>
	pid := interpreterProxy stackIntegerValue: 0.
	pgid := self getpgid: pid.
	pgid == -1 ifTrue: [^ interpreterProxy primitiveFail].
	interpreterProxy pop: 2; pushInteger: pgid