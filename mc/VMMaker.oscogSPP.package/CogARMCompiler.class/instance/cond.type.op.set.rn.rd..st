encoding
cond: conditionCode type: type op: flagsOrOpcode set: doUpdateStatusRegister rn:  sourceRegister rd: targetRegister
"build an instruction - cccctttoooo + source + target"
	<inline: true>
	^(self cond: conditionCode type: type op: flagsOrOpcode set: doUpdateStatusRegister) 
		bitOr: (sourceRegister << 16 bitOr: targetRegister << 12)