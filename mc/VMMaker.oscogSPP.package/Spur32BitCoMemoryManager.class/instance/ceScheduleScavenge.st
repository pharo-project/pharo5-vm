trampolines
ceScheduleScavenge
	<api>
	self assert: freeStart >= scavengeThreshold.
	self scheduleScavenge