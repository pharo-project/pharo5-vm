accessing
previousCommenter: aTParseNodeOrNil
	| previousValue |
	previousValue := previousCommenter.
	previousCommenter := aTParseNodeOrNil.
	^previousValue