accessing
newObjectHash
	"Use simple algorithm by D.H. Lehmer from 1951, for now."
	lastHash := lastHash * 16807 "7 raisedTo: 5" \\ 16r7ffffffd "(2 raisedTo: 31) - 1".
	self assert: lastHash ~= 0.
	^lastHash