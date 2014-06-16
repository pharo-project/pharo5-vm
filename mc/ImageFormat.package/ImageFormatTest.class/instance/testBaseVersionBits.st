testing
testBaseVersionBits

	self assert: ImageFormat baseVersionMask = 16r119EE.
	self assert: (ImageFormat wordSize: 4) baseVersionBits = 6502.
	self assert: (ImageFormat new fromInteger: 6504) baseVersionBits = 6504.
	self assert: (ImageFormat wordSize: 8) baseVersionBits = 68000.
	self assert: (ImageFormat new fromInteger: 68002) baseVersionBits = 68002.
