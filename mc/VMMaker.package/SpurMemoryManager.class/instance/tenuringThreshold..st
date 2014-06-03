accessing
tenuringThreshold: threshold
	"c.f. tenuringThreshold"
	scavenger scavengerTenuringThreshold:
		(threshold * self averageObjectSizeInBytes) asFloat
		/ scavenger pastSpaceBytes asFloat