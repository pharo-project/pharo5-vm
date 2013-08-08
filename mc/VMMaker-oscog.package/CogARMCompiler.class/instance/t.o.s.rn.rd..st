encoding
t: type o: flagsOrOpcode s: doUpdateStatusRegister rn:  sourceRegister rd: targetRegister
	<inline: true>
	^(self c: AL t: type o: flagsOrOpcode s: doUpdateStatusRegister) 
		bitOr: (sourceRegister << 16 bitOr: targetRegister << 12)