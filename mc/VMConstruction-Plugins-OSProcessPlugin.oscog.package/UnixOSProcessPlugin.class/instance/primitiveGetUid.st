primitives - OS process access
primitiveGetUid
	"Answer the user ID of my OS process"

	| uid |
	<export: true>
	<var: 'uid' type: 'uid_t'>
	uid := self getuid.
	interpreterProxy pop: 1; pushInteger: uid