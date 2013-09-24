object enumeration
objectAfter: objOop
	"Object parsing.
	1. all objects have at least a word following the header, for a forwarding pointer.
	2. objects with an overflow size have a preceeing word with a saturated slotSize.  If the word following
	    an object doesn't have a saturated size field it must be a single-header object.  If the word following
	   does have a saturated slotSize it must be the overflow size word."
	objOop < newSpaceLimit ifTrue:
		[(self isInEden: objOop) ifTrue:
			[^self objectAfter: objOop limit: freeStart].
		 (self isInSurvivorSpace: objOop) ifTrue:
			[^self objectAfter: objOop limit: pastSpaceStart].
		 ^self objectAfter: objOop limit: scavenger futureSurvivorStart].
	^self objectAfter: objOop limit: freeOldSpaceStart