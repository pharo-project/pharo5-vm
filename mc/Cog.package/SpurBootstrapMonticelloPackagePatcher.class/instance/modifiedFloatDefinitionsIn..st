private-accessing
modifiedFloatDefinitionsIn: definitions
	"Delete the non-accessing primitives in Float (prims 41 through 59),
	 and copy them to BoxedFloat64,
	 and create corresponding ones in SmallFloat64 with primtiive numbers + 500."
	| floatPrims |
	floatPrims := definitions select:
					[:d| | index |
					d isMethodDefinition
					and: [d fullClassName = #Float
					and: [(index := d source indexOfSubCollection: '<primitive: ') > 0
					and: [(Integer readFrom: (ReadStream on: d source from: index + '<primitive: ' size to: index + '<primitive: ' size + 4))
							between: 41
							and: 59]]]].
	^(floatPrims collect:
		[:d|
		 MCMethodDefinition new
			initializeWithClassName: d className
			classIsMeta: false
			selector: d selector
			category: d category
			timeStamp: d timeStamp
			source: d source, 'DELETEME']),
	 (floatPrims collect:
		[:d|
		 MCMethodDefinition new
			initializeWithClassName: #BoxedFloat64
			classIsMeta: false
			selector: d selector
			category: d category
			timeStamp: d timeStamp
			source: d source]),
	 (floatPrims collect:
		[:d|
		 MCMethodDefinition new
			initializeWithClassName: #SmallFloat64
			classIsMeta: false
			selector: d selector
			category: d category
			timeStamp: 'eem 11/25/2014 07:54'
			source: (d source copyReplaceAll: '<primitive: ' with: '<primitive: 5')])