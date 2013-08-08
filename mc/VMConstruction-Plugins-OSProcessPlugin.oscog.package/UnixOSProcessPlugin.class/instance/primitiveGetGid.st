primitives - OS process access
primitiveGetGid
	"Answer the group ID of my OS process"

	| gid |
	<export: true>
	<var: 'gid' type: 'gid_t'>
	gid := self getgid.
	interpreterProxy pop: 1; pushInteger: gid