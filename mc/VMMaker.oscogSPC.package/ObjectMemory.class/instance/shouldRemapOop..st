gc -- compaction
shouldRemapOop: oop
	<api>
	"Answer if the oop should be remapped"
	<inline: true>
	^(self isNonIntegerObject: oop)
	  and: [self isObjectForwarded: oop]