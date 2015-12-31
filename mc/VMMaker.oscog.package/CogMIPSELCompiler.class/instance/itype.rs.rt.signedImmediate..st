encoding
itype: op rs: rs rt: rt signedImmediate: immediate	
	self assert: (op between: 0 and: 63).
	self assert: (rs between: 0 and: 31).
	self assert: (rt between: 0 and: 31).
	self assert: (immediate between: -16r8000 and: 16r7FFF).
	"signedImmediate < 0
		ifTrue: [unsignedImmediate := signedImmediate + 16r10000]
		ifFalse: [unsignedImmediate := signedImmediate].
	self assert: (unsignedImmediate between: 0 and: 16rFFFF)."
	^(((op << 26) bitOr: (rs << 21)) bitOr: (rt << 16)) bitOr: (immediate bitAnd: 16rFFFF)