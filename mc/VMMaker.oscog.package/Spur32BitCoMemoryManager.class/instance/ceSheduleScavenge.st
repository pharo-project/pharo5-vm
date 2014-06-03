trampolines
ceSheduleScavenge
	<api>
	self assert: freeStart >= scavengeThreshold.
	self scheduleScavenge