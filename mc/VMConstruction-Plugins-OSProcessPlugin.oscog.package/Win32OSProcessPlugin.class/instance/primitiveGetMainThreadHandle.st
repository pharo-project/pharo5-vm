primitives - OS process access
primitiveGetMainThreadHandle
	"Answer the ID of my main thread."

	| handle handleOop |
	<export: true>
	<var: 'handle' type: 'HANDLE'>
	handle := self GetCurrentThread.
	handleOop := self handleObjectFrom: handle.
	interpreterProxy pop: 1 thenPush: handleOop
