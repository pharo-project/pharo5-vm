encoding
type: type op: flagsOrOpcode set: doUpdateStatusRegister rn:  sourceRegister rd: targetRegister
	<inline: true>
	^(self cond: AL type: type op: flagsOrOpcode set: doUpdateStatusRegister) 
		bitOr: (sourceRegister << 16 bitOr: targetRegister << 12)