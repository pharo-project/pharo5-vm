computation
dotpData: data endIndex: endIndex filter: filter start: start stop: stop inc: inc
	| sum i j |
	sum := 0.0.
	j := endIndex.
	i := start.
	[i <= stop] whileTrue:
		[sum := sum + ((data at: j) * (filter at: i)).
		i := i + inc.
		j := j - 1].
	^ sum