reporting
macOSDateFor: dateString 
	| tokens |
	tokens := dateString subStrings: ' -.+'.
	^TimeStamp
		date: (Date year: tokens first asInteger month: tokens second asInteger day: tokens third asInteger)
		time: tokens fourth asTime