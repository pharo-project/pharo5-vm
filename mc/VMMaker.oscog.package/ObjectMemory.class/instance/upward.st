gc -- mark and sweep
upward
	"Return from marking an object below. Incoming: 
		field = oop we just worked on, needs to be put away 
		parentField = where to put it in our object 
	NOTE: Type field of object below has already been restored!!!
	 See comment in markAndTrace for explanation of 
	 tracer state variables, and aComment for gory details."
	| type header |
	<inline: true>
	[(parentField bitAnd: 1) = 0 ifTrue:
		["normal"
		child := field. "who we worked on below"
		field := parentField. "where to put it"
		parentField := self longAt: field.
		self longAt: field put: child.
		field := field - self wordSize. "point at header"
		^ StartField].
	 parentField = GCTopMarker ifTrue:
		["top of the chain"
		header := (self longAt: field) bitAnd: AllButTypeMask.
		type := self rightType: header.
		self longAt: field put: (header bitOr: type). "install type on class oop"
		^ Done].
	"was working on the extended class word"
	child := field. "oop of class"
	field := parentField - 1. "class word, ** clear the low bit **"
	parentField := self longAt: field.
	header := self longAt: field + self wordSize. "base header word"
	type := self rightType: header.
	self longAt: field put: (child bitOr: type). "install type on class oop"
	field := field + self wordSize. "point at header"
	"restore type bits"
	header := header bitAnd: AllButTypeMask.
	self longAt: field put: (header bitOr: type).
	"Effectively ^ Upward"
	true] whileTrue.
	^nil "for Slang..."