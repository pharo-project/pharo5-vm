generation scavenging
remapObj: objOop
	"Scavenge or simply follow objOop.  Answer the new location of objOop.  The
	 send should have been guarded by a send of shouldRemapOop: or shouldScavengeObj:.
	 The method is called remapObj: for compatibility with ObjectMemory."
	<inline: false>
	| resolvedObj |
	(self isForwarded: objOop)
		ifTrue:
			[resolvedObj := self followForwarded: objOop.
			(self isYoung: resolvedObj) ifFalse: "a becommed object whose target is in old space"
				[^resolvedObj].
			(self isInFutureSpace: resolvedObj) ifTrue: "already scavenged"
				[^resolvedObj]]
		ifFalse:
			[resolvedObj := objOop].
	^scavenger copyAndForward: resolvedObj