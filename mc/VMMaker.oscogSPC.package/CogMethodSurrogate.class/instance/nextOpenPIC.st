accessing
nextOpenPIC
	| moField |
	moField := self methodObject.
	^moField ~= 0 ifTrue:
		[cogit cogMethodSurrogateAt: moField]