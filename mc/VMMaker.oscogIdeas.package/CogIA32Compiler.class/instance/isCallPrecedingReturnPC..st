testing
isCallPrecedingReturnPC: mcpc
	"Assuming mcpc is a send return pc answer if the instruction before it is a call (not a CallFull)."
	^(objectMemory byteAt: mcpc - 5) = 16rE8