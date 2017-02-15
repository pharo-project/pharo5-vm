simulation stack
updateSimSpillBase
	<inline: true>
	simSpillBase > simStackPtr ifTrue:
		[simSpillBase := simStackPtr max: 0].