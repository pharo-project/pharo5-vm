simulation stack
updateSimSpillBase
	simSpillBase > simStackPtr ifTrue:
		[simSpillBase := simStackPtr max: 0].