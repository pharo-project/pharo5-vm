gc - scavenging
checkForAvailableSlots: slots
	"Check for slots worth of free space being available.  Answer if that many slots are available.
	 If that many slots are not availabe, schedule a scavenge."
	<inline: true>
	freeStart + (self bytesPerOop * slots) <= scavengeThreshold ifTrue:
		[^true].
	needGCFlag := true.
	^false