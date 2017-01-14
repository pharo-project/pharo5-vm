other
computeSqrt: length2
	length2 < 32 
		ifTrue:[^self smallSqrtTable at: length2]
		ifFalse:[^(length2 asFloat sqrt + 0.5) asInteger]