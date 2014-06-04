accessing
long32At: index
	| idx |
	idx := (offset + index) // 4 + 1.
	"Note: This is a special hack for BitBlt."
	(idx = (object basicSize + 1)) ifTrue:[^0].
	^object basicAt: idx