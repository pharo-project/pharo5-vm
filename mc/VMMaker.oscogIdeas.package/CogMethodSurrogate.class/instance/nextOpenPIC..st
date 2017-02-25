accessing
nextOpenPIC: cogMethodSurrogateOrNil
	^self methodObject: (cogMethodSurrogateOrNil ifNil: [0] ifNotNil: [cogMethodSurrogateOrNil asUnsignedInteger])