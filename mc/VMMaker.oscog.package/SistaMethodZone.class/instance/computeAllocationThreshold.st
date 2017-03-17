initialization
computeAllocationThreshold
	<inline: true>
	allocationThreshold := ((limitAddress - baseAddress * thresholdRatio) asUnsignedInteger + (self zoneAlignment - 1) truncateTo: self zoneAlignment) + baseAddress