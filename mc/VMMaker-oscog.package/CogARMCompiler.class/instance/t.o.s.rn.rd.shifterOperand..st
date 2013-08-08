encoding
t: type o: flagsOrOpcode s: doUpdateStatusRegister rn:  sourceRegister rd: targetRegister shifterOperand: so
	<inline: true>
	^(self t: type o: flagsOrOpcode s: doUpdateStatusRegister rn: sourceRegister rd: targetRegister) bitOr: so