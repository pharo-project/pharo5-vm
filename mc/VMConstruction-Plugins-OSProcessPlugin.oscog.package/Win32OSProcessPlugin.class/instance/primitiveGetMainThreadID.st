primitives - OS process access
primitiveGetMainThreadID
	"Answer the ID of my main thread."

	| tid tidOop |
	<export: true>
	<var: 'tid' type: 'DWORD'>
	tid := self GetCurrentThreadId.
	tidOop := interpreterProxy positive32BitIntegerFor: tid.
	interpreterProxy pop: 1 thenPush: tidOop
