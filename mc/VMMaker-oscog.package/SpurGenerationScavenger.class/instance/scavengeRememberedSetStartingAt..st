scavenger
scavengeRememberedSetStartingAt: n
	"scavengeRememberedSetStartingAt: n traverses objects in the remembered
	 set starting at the nth one.  If the object does not refer to any new objects, it
	 is removed from the set. Otherwise, its new referents are scavenged."
	| destIndex sourceIndex |
	sourceIndex := destIndex := n.
	[sourceIndex < rememberedSetSize] whileTrue:
		[| referree |
		"*Don't* follow forwarding pointers here. oldSpace objects may refer
		 to these roots, and so they can't be removed in the scavenge."
		referree := rememberedSet at: sourceIndex.
		(self scavengeReferentsOf: referree)
			ifTrue:
				[rememberedSet at: destIndex put: referree.
				 destIndex := destIndex + 1]
			ifFalse:
				[manager setIsRememberedOf: referree to: false].
		 sourceIndex := sourceIndex + 1].
	rememberedSetSize := destIndex