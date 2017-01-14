gc -- compaction
objectIsImmutableAndReferencesForwarded: oop 
	"Answer if an object is immutable and references a forwarded object.  Used to fail become for immutable referents of becomees."
	"Note: The given oop may be forwarded itself, which means that its real header is in its forwarding table entry."
	| fieldOffset fieldOop |
	<inline: true>
	(self isImmutableWhileForwarding: oop) ifTrue:
		[fieldOffset := self lastPointerWhileForwarding: oop.
		[fieldOffset >= self baseHeaderSize] whileTrue:
			[fieldOop := self longAt: oop + fieldOffset.
			(self isObjectForwarded: fieldOop) ifTrue: [^true].
			 fieldOffset := fieldOffset - self wordSize]].
	^false