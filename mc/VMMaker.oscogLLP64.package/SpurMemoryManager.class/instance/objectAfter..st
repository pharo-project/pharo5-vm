object enumeration
objectAfter: objOop
	<api>
	"Object parsing.
	1. all objects have at least a word following the header, for a forwarding pointer.
	2. objects with an overflow size have a preceeing word with a saturated slotSize.  If the word following
	    an object doesn't have a saturated size field it must be a single-header object.  If the word following
	   does have a saturated slotSize it must be the overflow size word."
	<inline: false>
	(self oop: objOop isLessThan: newSpaceLimit) ifTrue:
		[(self isInEden: objOop) ifTrue:
			[^self objectAfter: objOop limit: freeStart].
		 (self isInPastSpace: objOop) ifTrue:
			[^self objectAfter: objOop limit: pastSpaceStart].
		 ^self objectAfter: objOop limit: scavenger futureSurvivorStart].
	^self objectAfter: objOop limit: endOfMemory