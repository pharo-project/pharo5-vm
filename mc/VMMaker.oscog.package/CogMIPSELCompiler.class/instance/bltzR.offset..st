encoding - control
bltzR: cmpReg offset: offset
	self assert: (offset bitAnd: 3) = 0.
	self assert: (offset between: -16r20000 and: 16r1FFFF).
	^self itype: REGIMM rs: cmpReg rt: BLTZ signedImmediate: offset >>> 2