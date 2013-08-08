primitives - OS process access
primitiveGetEUid
	"Answer the effective user ID of my OS process"

	| eUid |
	<export: true>
	<var: 'eUid' type: 'uid_t'>
	eUid := self geteuid.
	interpreterProxy pop: 1; pushInteger: eUid