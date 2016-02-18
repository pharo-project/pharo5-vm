accessing
nextPage
	^stackPages surrogateAtAddress: (memory unsignedLong64At: address + 65)