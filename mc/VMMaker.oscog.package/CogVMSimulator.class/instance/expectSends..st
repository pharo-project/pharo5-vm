debug support
expectSends: anArray
	expectedSends := ReadStream on: anArray.
	expecting := true