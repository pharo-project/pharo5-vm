generation scavenging
scavengingGC
	"Run the scavenger."
	self halt: (statScavenges + 1) printString, (#('st' 'nd' 'rd') at: (statScavenges + 1) \\ 10 ifAbsent: 'th'), ' scavenge'.
	^super scavengingGC