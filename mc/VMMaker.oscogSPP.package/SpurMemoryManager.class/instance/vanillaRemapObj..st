gc - scavenge/compact
vanillaRemapObj: objOop
	"Scavenge or simply follow objOop.  Answer the new location of objOop.
	 The send should have been guarded by a send of shouldRemapOop:.
	 The method is called remapObj: for compatibility with ObjectMemory."
	<inline: true>
	| resolvedObj |
	self assert: (self shouldRemapOop: objOop).
	(self isForwarded: objOop)
		ifTrue:
			[resolvedObj := self followForwarded: objOop]
		ifFalse:
			[self deny: (self isInFutureSpace: objOop).
			 resolvedObj := objOop].
	(self scavengeInProgress
	 and: [(self isReallyYoung: resolvedObj) "don't scavenge immediate, old, or CogMethod objects."
	 and: [(self isInFutureSpace: resolvedObj) not]]) ifTrue: 
		[^scavenger copyAndForward: resolvedObj].
	^resolvedObj