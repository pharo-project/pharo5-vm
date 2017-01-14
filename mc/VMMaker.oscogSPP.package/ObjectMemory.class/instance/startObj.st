gc -- mark and sweep
startObj
	"Start tracing the object 'child' and answer the next action. 
	 The object may be anywhere in the middle of being swept 
	 itself. See comment in markAndTrace for explanation of 
	 tracer state variables, and aComment for gory details."
	| header lastFieldOffset |
	<inline: true>
	statMarkCountLocal := statMarkCountLocal + 1.
	((self oop: child isLessThan: youngStartLocal) "old object; skip it"
	 or: [((header := self longAt: child) bitAnd: MarkBit) ~= 0]) "already marked; skip it"
		ifTrue:
			[field := child.
			^ Upward].
	"unmarked; mark and trace"
	lastFieldOffset := self lastPointerOf: child recordWeakRoot: false.
	header := (header bitAnd: AllButTypeMask) bitOr: (MarkBit bitOr: HeaderTypeGC).
	self longAt: child put: header.
	field := child + lastFieldOffset.
	^ StartField "trace its fields and class"