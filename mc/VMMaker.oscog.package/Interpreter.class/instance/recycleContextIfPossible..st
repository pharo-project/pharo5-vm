contexts
recycleContextIfPossible: cntxOop 
	"If possible, save the given context on a list of free contexts to 
	be recycled."
	"Note: The context is not marked free, so it can be reused 
	with minimal fuss. The recycled context lists are cleared at 
	every garbage collect."
	| header |
	<inline: true>
	"only recycle young contexts (which should be most of them)"
	(self oop: cntxOop isGreaterThanOrEqualTo: youngStart)
		ifTrue: [header := self baseHeader: cntxOop.
			(self isMethodContextHeader: header)
				ifTrue: ["It's a young context, alright."
					(header bitAnd: SizeMask) = SmallContextSize
						ifTrue: ["Recycle small contexts"
							self storePointerUnchecked: 0 ofObject: cntxOop withValue: freeContexts.
							freeContexts := cntxOop].
					(header bitAnd: SizeMask) = LargeContextSize
						ifTrue: ["Recycle large contexts"
							self storePointerUnchecked: 0 ofObject: cntxOop withValue: freeLargeContexts.
							freeLargeContexts := cntxOop]]]