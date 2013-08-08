testing
testHashBytesStartingWith

	| ba result |
	ba := #[1 2 3 4 5 6 7 8 9].
	result := self hashBytes: ba startingWith: 12345.
	self assert: result = 170953102
