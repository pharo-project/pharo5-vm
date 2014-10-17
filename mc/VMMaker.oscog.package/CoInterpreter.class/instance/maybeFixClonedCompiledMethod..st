cog jit support
maybeFixClonedCompiledMethod: objOop
	"Make sure a cloned method doesn't reference its originals Cog method, if any."
	| rawHeader |
	self assert: (objectMemory isOopCompiledMethod: objOop).
	rawHeader := self rawHeaderOf: objOop.
	(self isCogMethodReference: rawHeader) ifTrue:
		[self
			rawHeaderOf: objOop
			put: (self cCoerceSimple: rawHeader to: #'CogMethod *') methodHeader]