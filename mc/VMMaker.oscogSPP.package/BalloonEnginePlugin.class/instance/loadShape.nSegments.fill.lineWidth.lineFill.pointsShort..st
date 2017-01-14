shapes-polygons
loadShape: points nSegments: nSegments fill: fillIndex lineWidth: lineWidth lineFill: lineFill  pointsShort: pointsShort
	<inline: false>
	<var:#points type:'int *'>
	1 to: nSegments do:[:i|
		self loadCompressedSegment: i-1
			from: points
			short: pointsShort
			leftFill: fillIndex
			rightFill: 0
			lineWidth: lineWidth
			lineColor: lineFill.
		engineStopped ifTrue:[^nil].
	].