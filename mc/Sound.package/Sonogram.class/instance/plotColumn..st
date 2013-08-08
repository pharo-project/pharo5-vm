all
plotColumn: dataArray 
	| chm1 i normVal r |
	columnForm unhibernate.
	chm1 := columnForm height - 1.
	0 to: chm1
		do: 
			[:y | 
			i := y * (dataArray size - 1) // chm1 + 1.
			normVal := ((dataArray at: i) - minVal) / (maxVal - minVal).
			normVal := normVal max: 0.0.
			normVal := normVal min: 1.0.
			columnForm bits at: chm1 - y + 1
				put: (pixValMap at: (normVal * 255.0) truncated + 1)].
	(lastX := lastX + 1) > (image width - 1) ifTrue: [self scroll].
	image 
		copy: (r := lastX @ 0 extent: 1 @ image height)
		from: (32 // image depth - 1) @ 0
		in: columnForm
		rule: Form over.
	"self changed."
	self invalidRect: (r translateBy: self position)