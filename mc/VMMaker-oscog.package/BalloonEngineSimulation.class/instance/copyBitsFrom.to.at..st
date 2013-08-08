simulation
copyBitsFrom: x0 to: x1 at: y
	"Simulate the copyBits primitive"

	| bb |
	bbObj isInteger ifTrue:
		["Create a proxy object to handle BitBlt calls"
		bb := savedBBObj
				ifNil: [BitBltSimulator new
						initialiseModule;
						setInterpreter: interpreterProxy;
						yourself]
				ifNotNil: [savedBBObj].
		(bb loadBitBltFrom: bbObj)
			ifTrue: [bbObj := bb]
			ifFalse: [^ self]].
	bbObj copyBitsFrom: x0 to: x1 at: y.
"
	interpreterProxy showDisplayBits: bbObj destForm
		Left: bb affectedLeft Top: bb affectedTop
		Right: bb affectedRight Bottom: bb affectedBottom.
"