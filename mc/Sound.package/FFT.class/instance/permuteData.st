transforming
permuteData
	| i end a b |
	i := 1.
	end := permTable size.
	[i <= end] whileTrue:
		[a := permTable at: i.
		b := permTable at: i+1.
		realData swap: a with: b.
		imagData swap: a with: b.
		i := i + 2]