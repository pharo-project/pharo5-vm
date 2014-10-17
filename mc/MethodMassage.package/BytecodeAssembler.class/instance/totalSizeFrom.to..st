assembly
totalSizeFrom: startPC to: targetPC
	| sum |
	sum := 0.
	^(sizes at: targetPC) ifNotNil:
		[startPC <= targetPC
			ifTrue:
				[startPC to: targetPC do:
					[:i| sum := sum + (sizes at: i)]]
			ifFalse:
				[targetPC to: startPC - 1 do:
					[:i|
					"If a nil is found it will be for a forward branch in the first pass, and
					 the total size will be being requested by a backward branch.  Simply
					 answer anything negative.  All negative branches are long."
					(sizes at: i)
						ifNil: [^-1]
						ifNotNil: [:size| sum := sum - size]]].
		 sum]