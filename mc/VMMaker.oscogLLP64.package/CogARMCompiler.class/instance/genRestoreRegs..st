abi
genRestoreRegs: regMask
	"Restore the registers in regMask as saved by genSaveRegs:."
	<inline: true>
	^self genPopRegisterMask: regMask