simulation stack
ssPop: n
	self assert: (simStackPtr - n >= (methodOrBlockNumTemps - 1)
				or: [(needsFrame not and: [simStackPtr - n >= -1])
				or: [self maybeCompilingFirstPassOfBlockWithInitialPushNil]]).
	simStackPtr := simStackPtr - n