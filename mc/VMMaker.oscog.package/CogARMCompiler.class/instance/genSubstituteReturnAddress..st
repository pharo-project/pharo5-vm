abstract instructions
genSubstituteReturnAddress: retpc
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	"This code needs to be tightly correlated across:-
		GdbARMAlien>simulateJumpCallOf:memory:
		GdbARMAlien>simulateCallOf:nextpc:memory:
		GdbARMAlien>simulateReturnIn:
		GdbARMAlien>retpcIn:
		CogARMCompiler>genSubstituteReturnAddress:
	Getting any one of them doing something different will cause much pain"
	^cogit  PushCw: retpc