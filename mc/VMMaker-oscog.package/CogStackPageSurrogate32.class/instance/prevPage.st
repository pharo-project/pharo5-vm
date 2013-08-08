accessing
prevPage
	^stackPages surrogateAtAddress: (memory unsignedLongAt: address + 37)