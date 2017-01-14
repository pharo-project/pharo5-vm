gc - scavenging
flushNewSpace
	"Fush everything in new space.  Do so by setting the tenure
	 threshold above everything in newSpace, i.e. newSpaceLimit."
	| savedTenuringThreshold |
	savedTenuringThreshold := scavenger getRawTenuringThreshold.
	scavenger setRawTenuringThreshold: newSpaceLimit.
	self scavengingGCTenuringIf: TenureByAge.
	scavenger setRawTenuringThreshold: savedTenuringThreshold.
	self assert: scavenger rememberedSetSize = 0.
	self assert: pastSpaceStart = scavenger pastSpace start.
	self assert: freeStart = scavenger eden start