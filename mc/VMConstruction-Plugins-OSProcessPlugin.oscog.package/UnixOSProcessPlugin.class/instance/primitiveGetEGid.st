primitives - OS process access
primitiveGetEGid
	"Answer the effective group ID of my OS process"

	| eGid |
	<export: true>
	<var: 'eGid' type: 'gid_t'>
	eGid := self getegid.
	interpreterProxy pop: 1; pushInteger: eGid