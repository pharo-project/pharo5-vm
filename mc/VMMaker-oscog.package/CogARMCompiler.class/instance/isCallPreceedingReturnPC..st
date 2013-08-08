testing
isCallPreceedingReturnPC: mcpc
	"Assuming mcpc is a return pc answer if the instruction before it is a call."
	"There are two types of calls: BL and (MOV, ORR, ORR, ADD, ADD)"
	"PUSH {pc} is not sufficient as a test, because pc may be pushed using the PushR opcode"
	^ (objectMemory byteAt: mcpc - 3) >> 4 = 16rB "BL" 
			or: [ (objectMemory longAt: mcpc - 4) >> 12 = ((self t: 1 o: 4 s: 0 rn: RISCTempReg rd: PC)"add pc, r3, 0" >> 12) ]