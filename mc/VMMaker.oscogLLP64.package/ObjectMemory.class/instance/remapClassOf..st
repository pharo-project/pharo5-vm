gc -- compaction
remapClassOf: oop 
	"Update the class of the given object, if necessary, using its forwarding table entry."
	"Note: Compact classes need not be remapped since the compact class field is just an index into the compact class 
	table. The header type bits show if this object has a compact class; we needn't look up the oop's real header."
	| classHeader classOop newClassOop newClassHeader |
	(self headerType: oop) = HeaderTypeShort ifTrue: [^ nil]. "compact classes needn't be mapped"

	classHeader := self longAt: oop - self wordSize.
	classOop := classHeader bitAnd: AllButTypeMask.
	(self isObjectForwarded: classOop) ifTrue:
		[newClassOop := self remappedObj: classOop.
		newClassHeader := newClassOop bitOr: (classHeader bitAnd: TypeMask).
		self longAt: oop - self wordSize put: newClassHeader.
		"The following ensures that become: into an old object's class makes it a root. 
		It does nothing during either incremental or full compaction because 
		oop will never be < youngStart."
		((self oop: oop isLessThan: youngStart)
				and: [self oop: newClassOop isGreaterThanOrEqualTo: youngStart])
			ifTrue: [self beRootWhileForwarding: oop]]