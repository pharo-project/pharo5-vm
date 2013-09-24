accessing
tenuringThreshold: threshold
	"c.f. tenuringThreshold"
	scavenger scavengerTenuringThreshold:
		(threshold * 8 * self wordSize) asFloat
		/ scavenger pastSpaceBytes asFloat