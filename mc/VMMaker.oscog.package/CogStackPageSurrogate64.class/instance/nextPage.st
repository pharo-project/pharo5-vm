accessing
nextPage
	^stackPages surrogateAtAddress: (memory long64At: address + 65)