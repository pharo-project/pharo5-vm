gc - scavenging
flushEden
	"Fush everything in eden.  Do so by doing a non-tenuring scavenge."
	self scavengingGCTenuringIf: DontTenure.
	self assert: pastSpaceStart = scavenger pastSpace start.
	self assert: freeStart = scavenger eden start