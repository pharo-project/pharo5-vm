encoding
itype: op rs: rs rt: rt unsignedImmediate: immediate	
	self assert: (op between: 0 and: 63).
	self assert: (rs between: 0 and: 31).
	self assert: (rt between: 0 and: 31).
	self assert: (immediate between: 0 and: 16rFFFF).
	^(((op << 26) bitOr: (rs << 21)) bitOr: (rt << 16)) bitOr: immediate