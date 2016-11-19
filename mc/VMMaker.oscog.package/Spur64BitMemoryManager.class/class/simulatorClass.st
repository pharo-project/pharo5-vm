simulation only
simulatorClass
	^Spur64BitMMLESimulatorFor64Bits basicNew memoryClass
		ifNil: [Spur64BitMMLESimulator]
		ifNotNil: [Spur64BitMMLESimulatorFor64Bits]