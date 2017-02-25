encoding - control
bgezR: cmpReg offset: offset
	self assert: (offset bitAnd: 3) = 0.
	self assert: (offset between: -16r20000 and: 16r1FFFF).
	^self itype: REGIMM rs: cmpReg rt: BGEZ signedImmediate: offset >>> 2