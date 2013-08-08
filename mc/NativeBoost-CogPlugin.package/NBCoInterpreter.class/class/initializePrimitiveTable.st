as yet unclassified
initializePrimitiveTable
	super initializePrimitiveTable.
	self assert: (PrimitiveTable at: 220 + 1) = #primitiveFail.
	PrimitiveTable at: 220 + 1 put: #primitiveVoltage