compaction
scanForFirstFreeAndFirstMobileObjectFrom: initialObject
	"Scan from initialObject, setting firstMobileObject to the first marked object after
	 the first free object found. Answer the first free object found, or nil if none."
	<inline: false>
	| firstFree |
	manager allOldSpaceEntitiesFrom: initialObject do:
		[:o|
		(manager isMarked: o)
			ifTrue:
				[firstFree ifNotNil:
					[firstMobileObject := o.
					 ^firstFree]]
			ifFalse:
				[firstFree ifNil:
					[firstFree := o]]].
	^firstFree