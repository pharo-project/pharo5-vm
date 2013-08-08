encoding
c: conditionCode t: type o: flagsOrOpcode s: doUpdateStatusRegister rn:  sourceRegister rd: targetRegister shifterOperand: so
	<inline: true>
	^(self c: conditionCode t: type o: flagsOrOpcode s: doUpdateStatusRegister rn: sourceRegister rd: targetRegister) bitOr: so