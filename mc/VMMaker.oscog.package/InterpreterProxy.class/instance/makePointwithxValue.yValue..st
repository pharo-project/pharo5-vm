instance creation
makePointwithxValue: xValue yValue: yValue
	(xValue class == SmallInteger and:[yValue class == SmallInteger]) 
		ifFalse:[self error:'Not SmallInteger objects'].
	^xValue@yValue