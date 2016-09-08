encoding - control
beqR: leftReg R: rightReg offset: offset
	self assert: (offset bitAnd: 3) = 0.
	self assert: (offset between: -16r20000 and: 16r1FFFF).
	^self itype: BEQ rs: leftReg rt: rightReg signedImmediate: offset >>> 2