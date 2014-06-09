testing
isCallPreceedingReturnPC: mcpc
	"Assuming mcpc is a return pc answer if the instruction before it is a call."
	"There are two types of calls: BL and/BLX encoding"
	| call |
	call := self instructionBeforeAddress: mcpc.
	^(self instructionIsBL: call) or:[self instructionIsBLX: call]