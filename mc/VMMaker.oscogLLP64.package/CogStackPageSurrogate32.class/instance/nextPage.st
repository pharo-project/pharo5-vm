accessing
nextPage
	^stackPages surrogateAtAddress: (memory unsignedLongAt: address + 33)