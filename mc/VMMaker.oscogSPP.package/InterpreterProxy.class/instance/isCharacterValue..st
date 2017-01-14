testing
isCharacterValue: anInteger
	<option: #(atLeastVMProxyMajor:minor: 1 13)>
	^(self isIntegerValue: anInteger) and: [anInteger >= 0]