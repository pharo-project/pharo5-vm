as yet unclassified
swapArray

	SmalltalkImage current isBigEndian 
		ifTrue: [ ^#(0 1 2 3) ]
		ifFalse: [ ^#(3 2 1 0) ]