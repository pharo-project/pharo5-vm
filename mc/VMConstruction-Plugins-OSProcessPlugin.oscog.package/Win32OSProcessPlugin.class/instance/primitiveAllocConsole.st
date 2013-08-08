primitives - console
primitiveAllocConsole
	"Allocate a console if not already allocated. Answer true on success."

	<export: true>
	self AllocConsole
		ifTrue: [interpreterProxy pop: 1 thenPush: interpreterProxy trueObject]
		ifFalse: [interpreterProxy pop: 1 thenPush: interpreterProxy falseObject]
