private
alienMethodNamed: aString 
	| address |
	address := alienHandle primFindSymbol: aString.
	^ Alien forPointer: address.