compiled methods
isHandlerMarked: aContext
	"Is this a MethodContext whose meth has a primitive number of 199?"
	| header meth pIndex |
	"NB: the use of a primitive number for marking the method is pretty grungy, but it is simple to use for a test sytem, not too expensive and we don't actually have the two spare method header bits we need. We can probably obtain them when the method format is changed.
	NB 2: actually, the jitter will probably implement the prim to actually mark the volatile frame by changing the return function pointer."
	<inline: true>
	header := self baseHeader: aContext.
	(self isMethodContextHeader: header) ifFalse: [^false].
	meth := self fetchPointer: MethodIndex ofObject: aContext.
	pIndex := self primitiveIndexOf: meth.
	^pIndex == 199
