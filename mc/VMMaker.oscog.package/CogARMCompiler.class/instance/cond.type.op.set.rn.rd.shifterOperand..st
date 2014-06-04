encoding
cond: conditionCode type: type op: flagsOrOpcode set: doUpdateStatusRegister rn:  sourceRegister rd: targetRegister shifterOperand: so
	<inline: true>
	^(self cond: conditionCode type: type op: flagsOrOpcode set: doUpdateStatusRegister rn: sourceRegister rd: targetRegister) bitOr: (so bitAnd: 16rFFF)