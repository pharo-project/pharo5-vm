object map
oopForObject: o
	o isNumber
		ifTrue:
			[o isInteger
				ifTrue:
					[(o between: objectMemory minSmallInteger and: objectMemory maxSmallInteger) ifTrue:
						[^objectMemory integerObjectOf: o asInteger]]
				ifFalse:
					[o isFloat ifTrue:
						[(objectMemory isSmallFloatValue: o) ifTrue:
							[^objectMemory smallFloatValueOf: o]]]]
		ifFalse:
			[o isCharacter ifTrue:
				[^objectMemory characterObjectOf: o asInteger]].
	^objectMap at: o ifAbsentPut: [objectMap size * 8 + (1024 * 1024)]