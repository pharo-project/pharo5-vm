converting
asShortThenDispose

	| short |
	short := self asShort.
	self dispose.
	^short