converting
asStringThenDispose

	| string |
	string := self asString.
	self dispose.
	^string