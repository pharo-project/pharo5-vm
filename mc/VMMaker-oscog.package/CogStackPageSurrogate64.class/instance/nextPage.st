accessing
nextPage
	^stackPages surrogateAtAddress: (memory unsignedLongLongAt: address + 65)