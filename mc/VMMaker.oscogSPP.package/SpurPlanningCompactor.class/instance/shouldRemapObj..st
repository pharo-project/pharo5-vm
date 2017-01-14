gc - scavenge/compact
shouldRemapObj: objOop
	"Answer if the obj should be scavenged, or simply followed. Sent via the compactor
	 from shouldRemapObj:.  We test for being already scavenged because mapStackPages
	 via mapInterpreterOops may be applied twice in the context of a global GC where a
	 scavenge, followed by a scan-mark-free, and final compaction passes may result in
	 scavenged fields being visited twice."
	<api>
	<inline: false>
	^manager slidingCompactionShouldRemapObj: objOop