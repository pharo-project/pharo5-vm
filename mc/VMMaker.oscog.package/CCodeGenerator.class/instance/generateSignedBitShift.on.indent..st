C translation
generateSignedBitShift: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| cast type arg |
	"since ``signed'' is a synonym for ``signed int'' do not cast 64-bit values to signed if at all possible."
	cast := (self is64BitIntegralVariable: msgNode receiver typeInto: [:t| type := t])
				ifTrue: ['(', (type first = $u ifTrue: [type allButFirst: (type second = $n ifTrue: [2] ifFalse: [1])] ifFalse: [type]), ')']
				ifFalse: ['(signed)'].
	(arg := msgNode args first) isConstant
		ifTrue: "bit shift amount is a constant"
			[aStream nextPut: $(; nextPutAll: cast.
			self emitCExpression: msgNode receiver on: aStream.
			arg value < 0
				ifTrue: [aStream nextPutAll: ' >> '; print: arg value negated]
				ifFalse: [aStream nextPutAll: ' << '; print: arg value].
			aStream nextPut: $)]
		ifFalse: "bit shift amount is an expression"
			[aStream nextPutAll: '(('.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: ' < 0) ? ('; nextPutAll: cast.
			self emitCExpression: msgNode receiver on: aStream.
			aStream nextPutAll: ' >> -'.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: ') : ('; nextPutAll: cast.
			self emitCExpression: msgNode receiver on: aStream.
			aStream nextPutAll: ' << '.
			self emitCExpression: arg on: aStream.
			aStream nextPutAll: '))']