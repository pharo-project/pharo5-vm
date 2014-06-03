garbage collection
method: methodA hasSameCodeAs: methodB
	"For the purposes of become: see if the two methods are similar, i.e. can be safely becommed.
	 This is pretty strict.  All literals and bytecodes must be identical.  Only trailer bytes and header
	  flags can differ."
	<inline: false>
	| headerA headerB numLitsA endPCA |
	headerA := coInterpreter headerOf: methodA.
	headerB := coInterpreter headerOf: methodB.
	numLitsA := coInterpreter literalCountOfHeader: headerA.
	endPCA := self endPCOf: methodA.
	((coInterpreter argumentCountOfMethodHeader: headerA) ~= (coInterpreter argumentCountOfMethodHeader: headerB)
	 or: [(coInterpreter temporaryCountOfMethodHeader: headerA) ~= (coInterpreter temporaryCountOfMethodHeader: headerB)
	 or: [(coInterpreter primitiveIndexOfMethod: methodA header: headerA) ~= (coInterpreter primitiveIndexOfMethod: methodB header: headerB)
	 or: [numLitsA ~= (coInterpreter literalCountOfHeader: headerB)
	 or: [endPCA > (objectMemory byteLengthOf: methodB)]]]]) ifTrue:
		[^false].
	 1 to: numLitsA - 1 do:
		[:li|
		(objectMemory fetchPointer: li ofObject: methodA) ~= (objectMemory fetchPointer: li ofObject: methodB) ifTrue:
			[^false]].
	(coInterpreter startPCOfMethod: methodA) to: endPCA do:
		[:bi|
		(objectMemory fetchByte: bi ofObject: methodA) ~= (objectMemory fetchByte: bi ofObject: methodB) ifTrue:
			[^false]].
	^true