encoding - control
blezR: cmpReg offset: offset
	self assert: (offset bitAnd: 3) = 0.
	self assert: (offset between: -16r20000 and: 16r1FFFF).
	^self itype: BLEZ rs: cmpReg rt: 0 signedImmediate: offset >>> 2