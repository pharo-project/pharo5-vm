FILL processing
findStackFill: fillIndex depth: depth
	| index |
	index := 0.
	[index < self stackFillSize and:[
		(self stackFillValue: index) ~= fillIndex or:[
			(self stackFillDepth: index) ~= depth]]]
				whileTrue:[index := index + self stackFillEntryLength].
	index >= self stackFillSize 
		ifTrue:[^-1]
		ifFalse:[^index].
