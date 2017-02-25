deflating
compare: here with: matchPos min: minLength
	"Compare the two strings and return the length of matching characters.
	minLength is a lower bound for match lengths that will be accepted.
	Note: here and matchPos are zero based."
	| length |
	<inline: true>
	"First test if we can actually get longer than minLength"
	(zipCollection at: here+minLength) = (zipCollection at: matchPos+minLength)
		ifFalse:[^0].
	(zipCollection at: here+minLength-1) = (zipCollection at: matchPos+minLength-1)
		ifFalse:[^0].
	"Then test if we have an initial match at all"
	(zipCollection at: here) = (zipCollection at: matchPos)
		ifFalse:[^0].
	(zipCollection at: here+1) = (zipCollection at: matchPos+1)
		ifFalse:[^1].
	"Finally do the real comparison"
	length := 2.
	[length < DeflateMaxMatch and:[
		(zipCollection at: here+length) = (zipCollection at: matchPos+length)]]
			whileTrue:[length := length + 1].
	^length