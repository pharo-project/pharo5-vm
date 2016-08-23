generate machine code - concretize
concretizePushOrPopMultipleRegisters: doPush
	self assert: (operands at: 0) ~= 0.
	machineCode at: 0 put: AL << 28
						  + (doPush     "2r100PUSWL"
								ifTrue: [2r10010010 << 20]
								ifFalse: [2r10001011 << 20])
						  + (SP << 16)
						  + (operands at: 0).
	^machineCodeSize := 4