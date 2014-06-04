gc - scavenging
remapObj: objOop
	"Scavenge or simply follow objOop.  Answer the new location of objOop.
	 The send should have been guarded by a send of shouldRemapOop:.
	 The method is called remapObj: for compatibility with ObjectMemory."
	<api>
	<inline: false>
	| resolvedObj |
	self assert: (self shouldRemapOop: objOop).
	(self isForwarded: objOop)
		ifTrue:
			[resolvedObj := self followForwarded: objOop.
			(self isInFutureSpace: resolvedObj) ifTrue: "already scavenged"
				[^resolvedObj]]
		ifFalse:
			[resolvedObj := objOop].
	(scavengeInProgress
	 and: [self isReallyYoung: resolvedObj]) ifFalse: "a becommed or compacted object whose target is in old space, or a CogMethod."
		[^resolvedObj].
	^scavenger copyAndForward: resolvedObj