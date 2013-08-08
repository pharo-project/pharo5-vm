objects from disk
startUp
	"Check if the word order has changed from the last save."

	| la |
	la := ShortIntegerArray classPool at: #LastSaveOrder.
	((la at: 2) = 42 and: [(la at: 1) = 13]) 
		ifTrue: [^self swapHalves]. "Reverse the two 16-bit halves."
				"Another reversal happened automatically which reversed the bytes."
