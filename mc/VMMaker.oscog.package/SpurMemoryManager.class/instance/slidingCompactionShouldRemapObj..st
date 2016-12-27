gc - scavenge/compact
slidingCompactionShouldRemapObj: objOop
	<inline: true>
	"Answer if the obj should be scavenged, or simply followed. Sent via the compactor
	 from shouldRemapObj:.  We test for being already scavenged because mapStackPages
	 via mapInterpreterOops may be applied twice in the context of a global GC where a
	 scavenge, followed by a scan-mark-free, and final compaction passes may result in
	 scavenged fields being visited twice."
	^(self isForwarded: objOop)
	   or: [gcPhaseInProgress > 0 "Hence either scavengeInProgress or slidingCompactionInProgress"
		   and: [self scavengeInProgress
					ifTrue: [(self isReallyYoungObject: objOop)
							and: [(self isInFutureSpace: objOop) not]]
					ifFalse: [compactor isMobile: objOop]]]