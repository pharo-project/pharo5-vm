C translation support
emitSignedComparison: operator for: msgNode on: aStream indent: level
	"Emit a signed comparison.
	 Make sure the receiver expression is signed if comparing against zero."

	| arg rcvrType |
	((arg := msgNode args first) isConstant
	and: [arg value isInteger
	and: [arg value = 0
	and: [(self typeFor: msgNode receiver in: currentMethod)
			ifNil: [false]
			ifNotNil: [:t| (rcvrType := t) first = $u]]]]) ifTrue:
		[aStream nextPut: $(; nextPutAll: (self signedTypeForIntegralType: rcvrType); nextPut: $)].
	self emitCExpression: msgNode receiver on: aStream.
	aStream space; nextPutAll: operator; space.
	self emitCExpression: arg on: aStream