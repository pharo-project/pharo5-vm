gc - scavenging
shouldRemapOop: oop
	<api>
	"Answer if the oop should be scavenged.. The method is called
	 shouldRemapOop: for compatibility with ObjectMemory."
	<inline: true>
	^(self isNonImmediate: oop)
	   and: [self shouldRemapObj: oop]