printing
writePopPushDetailsIn:  memory in: transcript for: aCogit
"if the next instruction is a pop or push, or a ldr/str that touches the SP, write the details ontranscript"
	| instr |

	[ instr := memory unsignedLongAt: self pc + 1 bigEndian: false] on: Error do:[:ex| ^self].
	(self instructionIsPop: instr) ifTrue:[transcript tab; nextPutAll: 'pop ', (memory unsignedLongAt: self sp + 1 bigEndian: false) hex , ' from ', (self sp hex); cr].
	(self instructionIsPush: instr) ifTrue:[transcript tab; nextPutAll: 'push ', (self register: ((instr bitAnd: 16rF000) >>12)) hex , ' to ', (self sp -4) hex; cr].

	(self instructionIsLDRSP: instr)  ifTrue:[| val|
		val := self r10 > memory size
			ifTrue:[aCogit simulatedVariableAt: self r10]
			ifFalse:[memory unsignedLongAt: self r10 + 1 bigEndian: false].
		transcript tab; nextPutAll: 'load SP', val hex , ' from ', (self r10) hex; cr].

	(self instructionIsSTRSP: instr)  ifTrue:[transcript tab; nextPutAll: 'store SP', (self sp) hex , ' to ', (self r10) hex; cr].