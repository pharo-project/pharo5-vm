gc - scavenging
shouldRemapObj: objOop
	<api>
	"Answer if the obj should be scavenged (or simply followed). The method is called
	 shouldRemapObj: for compatibility with ObjectMemory.  We test for being already
	 scavenged because mapStackPages via mapInterpreterOops may be applied twice
	 in the context of a global GC where a scavenge, followed by a scan-mark-free, and
	 final compaction passes may result in scvenged fields being visited twice."
	^(self isForwarded: objOop)
	  or: [(self isReallyYoungObject: objOop)
		 and: [(self isInFutureSpace: objOop) not]]