testing
isAddressRelativeToVarBase: varAddress
	<inline: true>
	<var: #varAddress type: #usqInt>
	"Support for addressing variables off the dedicated VarBaseReg"
	^varAddress notNil
	  and: [varAddress >= cogit varBaseAddress
	  and: [varAddress - cogit varBaseAddress < (1 << 12)]]