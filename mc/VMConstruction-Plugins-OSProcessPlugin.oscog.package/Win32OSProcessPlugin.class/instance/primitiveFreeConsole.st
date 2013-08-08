primitives - console
primitiveFreeConsole
	"Deallocate the console if allocated. Answer true on success."

	<export: true>
	self FreeConsole
		ifTrue: [interpreterProxy pop: 1 thenPush: interpreterProxy trueObject]
		ifFalse: [interpreterProxy pop: 1 thenPush: interpreterProxy falseObject]
