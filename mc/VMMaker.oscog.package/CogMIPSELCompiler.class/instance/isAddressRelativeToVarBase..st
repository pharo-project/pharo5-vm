testing
isAddressRelativeToVarBase: varAddress
	<inline: true>
	<var: #varAddress type: #usqInt>
	"Support for addressing variables off the dedicated VarBaseReg"
	^varAddress notNil
	  and: [(cogit varBaseAddress - (1 << 15)) < varAddress
	  and: [varAddress < (cogit varBaseAddress + (1 << 15))]]