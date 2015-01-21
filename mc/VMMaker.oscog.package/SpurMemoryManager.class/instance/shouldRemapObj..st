gc - scavenging
shouldRemapObj: objOop
	<api>
	"Answer if the obj should be scavenged (or simply followed). The method is called
	 shouldRemapObj: for compatibility with ObjectMemory."
	^(self isForwarded: objOop)
	  or: [self deny: (self isInFutureSpace: objOop).
		  self isReallyYoungObject: objOop]