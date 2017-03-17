accessing
tenuringThreshold: threshold
	"c.f. tenuringThreshold"
	threshold < 0 ifTrue:
		[^PrimErrBadArgument].
	scavenger scavengerTenuringThreshold:
		(threshold * self averageObjectSizeInBytes) asFloat
		/ scavenger pastSpaceBytes asFloat.
	^0