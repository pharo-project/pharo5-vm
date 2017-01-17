gc - scavenge/compact
remapObj: objOop
	"Scavenge or simply follow objOop.  Answer the new location of objOop.
	 The send should have been guarded by a send of shouldRemapOop:.
	 The method is called remapObj: for compatibility with ObjectMemory.
	 Defer to the compactor to choose the actual method, there being a
	 difference between the vanilla method and that used with a sliding
	 compactor where objects are not marked as forwarded."
	<doNotGenerate>
	^compactor remapObj: objOop