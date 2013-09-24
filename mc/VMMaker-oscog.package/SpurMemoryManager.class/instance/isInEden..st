object testing
isInEden: objOop
	^objOop >= scavenger eden start
	  and: [objOop < freeStart]