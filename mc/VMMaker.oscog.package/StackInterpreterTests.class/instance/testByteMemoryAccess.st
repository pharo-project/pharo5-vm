tests
testByteMemoryAccess
	"self new testByteMemoryAccess"
	| om |
	om := NewCoObjectMemorySimulator new allocateMemoryOfSize: 16.
	om byteAt: 0 put: 16r11.
	om byteAt: 1 put: 16r22.
	om byteAt: 2 put: 16r33.
	om byteAt: 3 put: 16r44.
	self assert: (om longAt: 0) equals: 16r44332211.
	self assert: (om byteAt: 0) equals: 16r11.
	self assert: (om byteAt: 1) equals: 16r22.
	self assert: (om byteAt: 2) equals: 16r33.
	self assert: (om byteAt: 3) equals: 16r44.
	om := Spur32BitMMLECoSimulator new allocateMemoryOfSize: 16.
	om byteAt: 0 put: 16r11.
	om byteAt: 1 put: 16r22.
	om byteAt: 2 put: 16r33.
	om byteAt: 3 put: 16r44.
	self assert: (om longAt: 0) equals: 16r44332211.
	self assert: (om byteAt: 0) equals: 16r11.
	self assert: (om byteAt: 1) equals: 16r22.
	self assert: (om byteAt: 2) equals: 16r33.
	self assert: (om byteAt: 3) equals: 16r44.
	om := Spur64BitMMLECoSimulator new allocateMemoryOfSize: 32.
	om byteAt: 0 put: 16r11.
	om byteAt: 1 put: 16r22.
	om byteAt: 2 put: 16r33.
	om byteAt: 3 put: 16r44.
	om byteAt: 4 put: 16r55.
	om byteAt: 5 put: 16r66.
	om byteAt: 6 put: 16r77.
	om byteAt: 7 put: 16r88.
	self assert: (om longAt: 0) equals: 16r8877665544332211.
	self assert: (om byteAt: 0) equals: 16r11.
	self assert: (om byteAt: 1) equals: 16r22.
	self assert: (om byteAt: 2) equals: 16r33.
	self assert: (om byteAt: 3) equals: 16r44.
	self assert: (om byteAt: 4) equals: 16r55.
	self assert: (om byteAt: 5) equals: 16r66.
	self assert: (om byteAt: 6) equals: 16r77.
	self assert: (om byteAt: 7) equals: 16r88.
	(Smalltalk classNamed: #DoubleWordArray) ifNotNil:
		[om := Spur64BitMMLECoSimulatorFor64Bits new allocateMemoryOfSize: 32.
		 om byteAt: 0 put: 16r11.
		 om byteAt: 1 put: 16r22.
		 om byteAt: 2 put: 16r33.
		 om byteAt: 3 put: 16r44.
		 om byteAt: 4 put: 16r55.
		 om byteAt: 5 put: 16r66.
		 om byteAt: 6 put: 16r77.
		 om byteAt: 7 put: 16r88.
		 self assert: (om longAt: 0) equals: 16r8877665544332211.
		 self assert: (om byteAt: 0) equals: 16r11.
		 self assert: (om byteAt: 1) equals: 16r22.
		 self assert: (om byteAt: 2) equals: 16r33.
		 self assert: (om byteAt: 3) equals: 16r44.
		 self assert: (om byteAt: 4) equals: 16r55.
		 self assert: (om byteAt: 5) equals: 16r66.
		 self assert: (om byteAt: 6) equals: 16r77.
		 self assert: (om byteAt: 7) equals: 16r88]