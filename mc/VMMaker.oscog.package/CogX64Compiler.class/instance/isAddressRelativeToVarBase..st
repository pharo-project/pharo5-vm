testing
isAddressRelativeToVarBase: varAddress
	<inline: true>
	<var: #varAddress type: #usqInt>
	"Support for addressing variables off the dedicated VarBaseReg.  Allow for 1Mb of variables.
	 The x64 supports 32-bit offsets, but we choose not to address everything from VarBaseReg."
	^varAddress notNil
	  and: [varAddress >= cogit varBaseAddress
	  and: [varAddress - cogit varBaseAddress < (1 << 20)]]