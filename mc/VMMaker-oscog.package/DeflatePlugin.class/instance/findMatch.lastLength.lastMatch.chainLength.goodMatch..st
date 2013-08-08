deflating
findMatch: here lastLength: lastLength lastMatch: lastMatch chainLength: maxChainLength goodMatch: goodMatch
	"Find the longest match for the string starting at here.
	If there is no match longer than lastLength return lastMatch/lastLength.
	Traverse at most maxChainLength entries in the hash table.
	Stop if a match of at least goodMatch size has been found."
	| matchResult matchPos distance chainLength limit bestLength length |
	<inline: false>
	"Compute the default match result"
	matchResult := (lastLength bitShift: 16) bitOr: lastMatch.

	"There is no way to find a better match than MaxMatch"
	lastLength >= DeflateMaxMatch ifTrue:[^matchResult].

	"Start position for searches"
	matchPos := zipHashHead at: (self updateHashAt: here + DeflateMinMatch - 1).

	"Compute the distance to the (possible) match"
	distance := here - matchPos.

	"Note: It is required that 0 < distance < MaxDistance"
	(distance > 0 and:[distance < DeflateMaxDistance]) ifFalse:[^matchResult].

	chainLength := maxChainLength.	"Max. nr of match chain to search"
	here > DeflateMaxDistance	"Limit for matches that are too old"
		ifTrue:[limit := here - DeflateMaxDistance]
		ifFalse:[limit := 0].

	"Best match length so far (current match must be larger to take effect)"
	bestLength := lastLength.

	[true] whileTrue:[
		"Compare the current string with the string at match position"
		length := self compare: here with: matchPos min: bestLength.
		"Truncate accidental matches beyound stream position"
		(here + length > zipPosition) ifTrue:[length := zipPosition - here].
		"Ignore very small matches if they are too far away"
		(length = DeflateMinMatch and:[(here - matchPos) > (DeflateMaxDistance // 4)])
			ifTrue:[length := DeflateMinMatch - 1].
		length > bestLength ifTrue:["We have a new (better) match than before"
			"Compute the new match result"
			matchResult := (length bitShift: 16) bitOr: matchPos.
			bestLength := length.
			"There is no way to find a better match than MaxMatch"
			bestLength >= DeflateMaxMatch ifTrue:[^matchResult].
			"But we may have a good, fast match"
			bestLength > goodMatch ifTrue:[^matchResult].
		].
		(chainLength := chainLength - 1) > 0 ifFalse:[^matchResult].
		"Compare with previous entry in hash chain"
		matchPos := zipHashTail at: (matchPos bitAnd: DeflateWindowMask).
		matchPos <= limit ifTrue:[^matchResult]. "Match position is too old"
	].