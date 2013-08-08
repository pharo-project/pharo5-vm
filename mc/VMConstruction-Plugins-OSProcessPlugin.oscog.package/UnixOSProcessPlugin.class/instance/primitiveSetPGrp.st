primitives - OS process access
primitiveSetPGrp
	"Set a new process group for this OS process. Newly created child processes
	will be members of the new process group. Note: Use setpgid(0,0) rather than
	the equivalent setpgrp() because setpgrp() is implemented differently on
	some flavors of Unix."

	<export: true>
	(self set: 0 pgid: 0) == -1 ifTrue: [^ interpreterProxy primitiveFail]
