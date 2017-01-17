accessing
nextOpenPIC: anObject
	"Set the value of nextOpenPIC (a.k.a. methodObject)"
	<cmacro: 'Hack hack hack hack i.e. the getter macro does all the work'>
	^methodObject := anObject