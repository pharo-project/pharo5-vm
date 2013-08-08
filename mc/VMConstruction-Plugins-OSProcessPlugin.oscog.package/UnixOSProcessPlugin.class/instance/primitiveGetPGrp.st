primitives - OS process access
primitiveGetPGrp
	"Answer the process group ID of this OS process"

	| pgid |
	<export: true>
	<var: 'pgid' type: 'pid_t'>
	pgid := self getpgrp.
	pgid == -1 ifTrue: [^ interpreterProxy primitiveFail].
	interpreterProxy pop: 1.
	interpreterProxy pushInteger: pgid