accessing
cPICNumCases: anObject
	"Set the value of cPICNumCases (a.k.a. stackCheckOffset)"
	<cmacro: 'Hack hack hack hack i.e. the getter macro does all the work'>
	^stackCheckOffset := anObject