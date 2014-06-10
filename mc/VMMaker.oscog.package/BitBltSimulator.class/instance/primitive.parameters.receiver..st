simulation
primitive: primitiveName parameters: parameterTypesArray receiver: rcvrType
	primitiveName caseOf: {
		['primitivePixelValueAt'] -> [^self] }