UI access
logDateAndTime
	| now |
	"do it this way since Time now includes milliseconds in some versions."
	now := Time dateAndTimeNow.
	logger print: now first; space; print: now last; cr; flush