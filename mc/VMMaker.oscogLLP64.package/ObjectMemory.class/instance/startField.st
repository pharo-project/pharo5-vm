gc -- mark and sweep
startField
	"Examine and possibly trace the next field of the object being
	 traced. See comment in markAndTrace for explanation of
	 tracer state variables, and aComment for gory details."
	| typeBits childType |
	<inline: true>
	[child := self longAt: field.
	 self isIntegerObject: child] whileTrue:
		["field contains a SmallInteger; skip it"
		field := field - self wordSize.
		"Effectively ^ StartField"].
	typeBits := child bitAnd: TypeMask.
	typeBits = 0 ifTrue: "normal oop, go down"
		[self longAt: field put: parentField.
		parentField := field.
		^ StartObj].
	self assert: typeBits = 2.
	"reached the header; do we need to process the class word? "
	(child bitAnd: CompactClassMask) ~= 0 ifTrue:
		["object's class is compact; we're done"
		"restore the header type bits"
		child := child bitAnd: AllButTypeMask.
		childType := self rightType: child.
		self longAt: field put: (child bitOr: childType).
		^ Upward].
	"object has a full class word; process that class"
	child := self longAt: field - self wordSize. "class word"
	child := child bitAnd: AllButTypeMask. "clear type bits"
	self longAt: field - self wordSize put: parentField.
	parentField := field - self wordSize bitOr: 1.
	"point at class word; mark as working on the class. "
	^ StartObj