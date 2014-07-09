disassembly
label
	"N.B. A Label is an Association so that later its pc can be sorted in its value field."
	| n |
	n := 0.
	labels doWithIndex:
		[:l :i|
		l ifTrue:
			[labels at: i put: (Association new key: 'L', (n := n + 1) printString value: i)]]