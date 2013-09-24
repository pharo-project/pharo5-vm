object testing
isInOldSpace: address 
	^address between: newSpaceLimit and: freeOldSpaceStart