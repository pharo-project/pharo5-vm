accessing
newSpaceSize
	^(freeStart - scavenger eden start)
	 + (pastSpaceStart - scavenger pastSpace start)