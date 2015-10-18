tests
testSignedIntFromFoo
	self assert: 16r55 signedIntFromChar equals: 16r55.
	self assert: 16r155 signedIntFromChar equals: 16r55.
	self assert: 16rAA signedIntFromChar < 0.
	self assert: (16rAA signedIntFromChar bitAnd: 16rFF) = 16rAA.

	self assert: 16r5555 signedIntFromShort equals: 16r5555.
	self assert: 16r15555 signedIntFromShort equals: 16r5555.
	self assert: 16rAAAA signedIntFromShort < 0.
	self assert: (16rAAAA signedIntFromShort bitAnd: 16rFFFF) = 16rAAAA.

	self assert: 16r55555555 signedIntFromLong equals: 16r55555555.
	self assert: 16r155555555 signedIntFromLong equals: 16r55555555.
	self assert: 16rAAAAAAAA signedIntFromLong< 0.
	self assert: (16rAAAAAAAA signedIntFromLong bitAnd: 16rFFFFFFFF) = 16rAAAAAAAA.

	self assert: 16r5555555555555555 signedIntFromLong64 equals: 16r5555555555555555.
	self assert: 16r15555555555555555 signedIntFromLong64 equals: 16r5555555555555555.
	self assert: 16rAAAAAAAAAAAAAAAA signedIntFromLong64< 0.
	self assert: (16rAAAAAAAAAAAAAAAA signedIntFromLong64 bitAnd: 16rFFFFFFFFFFFFFFFF) = 16rAAAAAAAAAAAAAAAA