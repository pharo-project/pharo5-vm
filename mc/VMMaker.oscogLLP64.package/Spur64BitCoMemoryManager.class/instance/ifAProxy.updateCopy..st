image segment in/out
ifAProxy: objOop updateCopy: copy
	"If the object being copied to the segment is weird and has exotic state,
	 i.e. a married context or a jitted method, update the copy with the vanilla state."

	super ifAProxy: objOop updateCopy: copy.
	(self isCompiledMethod: objOop) ifTrue:
		[| methodHeader |
		 methodHeader := coInterpreter rawHeaderOf: objOop.
		 (coInterpreter isCogMethodReference: methodHeader) ifTrue:
			[self storePointerUnchecked: HeaderIndex
				ofObject: copy
				withValue: (coInterpreter cCoerceSimple: methodHeader to: #'CogMethod *') methodHeader]]