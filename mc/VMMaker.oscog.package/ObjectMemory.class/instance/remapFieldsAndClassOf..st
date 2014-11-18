gc -- compaction
remapFieldsAndClassOf: oop 
	"Replace all forwarded pointers in this object with their new oops, using the forwarding table. Remap its class as well, if 
	necessary. "
	"Note: The given oop may be forwarded itself, which means that its real header is in its forwarding table entry."
	| fieldOffset fieldOop newOop |
	<inline: true>
	fieldOffset := self lastPointerWhileForwarding: oop.
	[fieldOffset >= self baseHeaderSize] whileTrue:
		[fieldOop := self longAt: oop + fieldOffset.
		(self isObjectForwarded: fieldOop) ifTrue:
			["update this oop from its forwarding block"
			newOop := self remappedObj: fieldOop.
			self longAt: oop + fieldOffset put: newOop.
			"The following ensures that become: into old object makes it a root. 
			It does nothing during either incremental or full compaction because 
			oop will never be < youngStart."
			((self oop: oop isLessThan: youngStart)
					and: [self oop: newOop isGreaterThanOrEqualTo: youngStart])
				ifTrue: [self beRootWhileForwarding: oop]].
		fieldOffset := fieldOffset - self wordSize].
	self remapClassOf: oop