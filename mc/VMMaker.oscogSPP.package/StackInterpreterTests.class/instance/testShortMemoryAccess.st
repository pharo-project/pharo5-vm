tests
testShortMemoryAccess
	"self new testShortMemoryAccess"
	| om |
	om := NewCoObjectMemorySimulator new allocateMemoryOfSize: 16.
	om shortAt: 0 put: 16r2211.
	om shortAt: 2 put: 16r4433.
	self assert: (om longAt: 0) equals: 16r44332211.
	self assert: (om shortAt: 0) equals: 16r2211.
	self assert: (om shortAt: 2) equals: 16r4433.
	om := Spur32BitMMLECoSimulator new allocateMemoryOfSize: 16.
	om shortAt: 0 put: 16r2211.
	om shortAt: 2 put: 16r4433.
	self assert: (om longAt: 0) equals: 16r44332211.
	self assert: (om shortAt: 0) equals: 16r2211.
	self assert: (om shortAt: 2) equals: 16r4433.
	om := Spur64BitMMLECoSimulator new allocateMemoryOfSize: 32.
	om shortAt: 0 put: 16r2211.
	om shortAt: 2 put: 16r4433.
	om shortAt: 4 put: 16r6655.
	om shortAt: 6 put: 16r8877.
	self assert: (om longAt: 0) equals: 16r8877665544332211.
	self assert: (om shortAt: 0) equals: 16r2211.
	self assert: (om shortAt: 2) equals: 16r4433.
	self assert: (om shortAt: 4) equals: 16r6655.
	self assert: (om shortAt: 6) equals: 16r8877.
	(Smalltalk classNamed: #DoubleWordArray) ifNotNil:
		[om := Spur64BitMMLECoSimulatorFor64Bits new allocateMemoryOfSize: 32.
		 om shortAt: 0 put: 16r2211.
		 om shortAt: 2 put: 16r4433.
		 om shortAt: 4 put: 16r6655.
		 om shortAt: 6 put: 16r8877.
		 self assert: (om longAt: 0) equals: 16r8877665544332211.
		 self assert: (om shortAt: 0) equals: 16r2211.
		 self assert: (om shortAt: 2) equals: 16r4433.
		 self assert: (om shortAt: 4) equals: 16r6655.
		 self assert: (om shortAt: 6) equals: 16r8877]