simulation
loadPointIntAt: index from: intArray
	"Load the int value from the given index in intArray"
	^(index bitAnd: 1) = 0
		ifTrue:[(intArray getObject at: (index // 2) + 1) x]
		ifFalse:[(intArray getObject at: (index // 2) + 1) y]