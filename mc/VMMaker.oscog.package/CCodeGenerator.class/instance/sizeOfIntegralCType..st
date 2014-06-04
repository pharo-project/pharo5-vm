inlining
sizeOfIntegralCType: anIntegralCType "<String>"
	"N.B. Only works for values for which isIntegralCType: answers true."
	| prunedCType index |
	prunedCType := (anIntegralCType beginsWith: 'unsigned ')
						ifTrue: [(anIntegralCType allButFirst: 9) withBlanksTrimmed]
						ifFalse: [(anIntegralCType beginsWith: 'signed ')
									ifTrue: [(anIntegralCType allButFirst: 7) withBlanksTrimmed]
									ifFalse: [anIntegralCType]].
	^prunedCType asString caseOf: {
		['sqLong']	->	[8].
		['usqLong']	->	[8].
		['sqInt']		->	[BytesPerWord].
		['usqInt']	->	[BytesPerWord].
		['int']		->	[4].
		['short']		->	[2].
		['char']		->	[1].
		['long']		->	[BytesPerWord].
		['size_t']		->	[BytesPerWord].
		['pid_t']		->	[BytesPerWord].
	}
	otherwise:
		[((anIntegralCType beginsWith: 'unsigned') "e.g. 'unsigned  : 8'"
		  and: [(anIntegralCType includesAnyOf: '[*]') not
		  and: [(index := anIntegralCType indexOf: $:) > 0]])
			ifTrue: [(Integer readFrom: (anIntegralCType copyFrom: index + 1 to: anIntegralCType size) withBlanksTrimmed readStream) + 7 // 8]
			ifFalse: [self error: 'unrecognized integral type']]