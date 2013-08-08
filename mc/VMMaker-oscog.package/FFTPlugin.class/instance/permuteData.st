transforming
permuteData
	| i end a b tmp |
	<var: #tmp type: 'float '>
	i := 0.
	end := permTableSize.
	[i < end] whileTrue:
		[a := (permTable at: i) - 1.
		b := (permTable at: i+1) - 1.

		(a < realDataSize and:[b < realDataSize]) ifFalse:[^interpreterProxy success: false].

		tmp := realData at: a.
		realData at: a put: (realData at: b).
		realData at: b put: tmp.

		tmp := imagData at: a.
		imagData at: a put: (imagData at: b).
		imagData at: b put: tmp.

		i := i + 2]