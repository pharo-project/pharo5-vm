encoding
cond: conditionCode type: type op: flagsOrOpcode set: doUpdateStatusRegister rn:  sourceRegister rd: targetRegister shifterOperand: so
"build an instruction - cccctttoooo + source + target + shifter op"
	<inline: true>
	^(self cond: conditionCode type: type op: flagsOrOpcode set: doUpdateStatusRegister rn: sourceRegister rd: targetRegister) bitOr: (so bitAnd: 16rFFF)