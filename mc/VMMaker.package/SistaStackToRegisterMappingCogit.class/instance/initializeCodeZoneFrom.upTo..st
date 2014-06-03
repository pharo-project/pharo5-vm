initialization
initializeCodeZoneFrom: startAddress upTo: endAddress
	initialCounterValue := MaxCounterValue.
	numCounters := 0.
	self allocateCounters.
	super initializeCodeZoneFrom: startAddress upTo: endAddress