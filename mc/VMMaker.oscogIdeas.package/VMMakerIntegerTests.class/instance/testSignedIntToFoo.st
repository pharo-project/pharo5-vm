tests
testSignedIntToFoo
	#(16r55 -16r56 16r5555 -16r5556 16r55555555 -16r55555556 16r5555555555555555 -16r5555555555555556) do:
		[:n|
		n abs digitLength = 1 ifTrue:
			[self assert: n signedIntToChar signedIntFromChar equals: n].
		self assert: (n signedIntToChar signedIntFromChar bitAnd: 16rFF) equals: (n bitAnd: 16rFF).
		n abs digitLength <= 2 ifTrue:
			[self assert: n signedIntToShort signedIntFromShort equals: n].
		self assert: (n signedIntToShort signedIntFromShort bitAnd: 16rFFFF) equals: (n bitAnd: 16rFFFF).
		n abs digitLength <= 4 ifTrue:
			[self assert: n signedIntToLong signedIntFromLong equals: n].
		self assert: (n signedIntToLong signedIntFromLong bitAnd: 16rFFFFFFFF) equals: (n bitAnd: 16rFFFFFFFF).
		n abs digitLength <= 8 ifTrue:
			[self assert: n signedIntToLong64 signedIntFromLong64 equals: n].
		self assert: (n signedIntToLong64 signedIntFromLong64 bitAnd: 16rFFFFFFFFFFFFFFFF) equals: (n bitAnd: 16rFFFFFFFFFFFFFFFF)]