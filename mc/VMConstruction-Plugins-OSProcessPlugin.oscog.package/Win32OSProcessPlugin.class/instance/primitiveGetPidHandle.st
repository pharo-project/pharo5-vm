primitives - OS process access
primitiveGetPidHandle
	"Answer the handle for my OS process"

	| handle handleOop |
	<export: true>
	<var: 'handle' type: 'HANDLE'>
	handle := self GetCurrentProcess.
	handleOop := self handleObjectFrom: handle.
	interpreterProxy pop: 1 thenPush: handleOop
