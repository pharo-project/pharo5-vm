computation
cSubstAngleFactorFrom: startDegreeNumber to: endDegreeNumber 
	| absDiff |
	absDiff := (endDegreeNumber - startDegreeNumber) abs.
	absDiff > 180 ifTrue: [absDiff := 360 - absDiff].
	^ absDiff * absDiff bitShift: -6