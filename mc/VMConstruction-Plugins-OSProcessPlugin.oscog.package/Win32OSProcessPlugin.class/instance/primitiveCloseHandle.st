primitives - handles
primitiveCloseHandle
	"Close the specified handle, which may refer to a process, a thread, or
	some other Win32 object."

	| handleOop handle result |
	<export: true>
	<var: 'handle' type: 'HANDLE'>
	<var: 'result' type: 'BOOL'>
	handleOop := interpreterProxy stackObjectValue: 0.
	(handle := self handleFrom: handleOop) isNil ifTrue: [^ nil].
	result := self CloseHandle: handle.
	interpreterProxy pop: 2.
	(result ~= 0)
		ifTrue: [interpreterProxy push: interpreterProxy trueObject]
		ifFalse: [interpreterProxy push: interpreterProxy falseObject]
