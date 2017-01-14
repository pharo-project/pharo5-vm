accessing
prevPage
	^stackPages surrogateAtAddress: (memory unsignedLong64At: address + 73)