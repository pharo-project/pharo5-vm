gc - scavenge/compact
shouldRemapObj: objOop
	<api>
	"Answer if the obj should be scavenged (or simply followed). The method is called
	 shouldRemapObj: for compatibility with ObjectMemory.  Defer to the compactor
	 to choose the actual test, there being a difference between the vanilla test and
	 that used with a sliding compactor where objects are not marked as forwarded."
	^manager vanillaShouldRemapObj: objOop