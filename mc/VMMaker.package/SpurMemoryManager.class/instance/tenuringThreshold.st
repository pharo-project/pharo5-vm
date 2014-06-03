accessing
tenuringThreshold
	"In the scavenger the tenuring threshold is effectively a number of bytes of objects,
	 accessed as a proportion of pastSpace from 0 to 1.   In the Squeak image the tenuring
	 threshold is an object count. Marry the two notions by multiplying the proportion by
	 the size of pastSpace and dividing by the average object size, as derived from observation."
	^(scavenger scavengerTenuringThreshold * scavenger pastSpaceBytes // self averageObjectSizeInBytes) asInteger