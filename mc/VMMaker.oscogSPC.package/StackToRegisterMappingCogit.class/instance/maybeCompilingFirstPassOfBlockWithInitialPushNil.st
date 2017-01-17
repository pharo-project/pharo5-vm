debugging
maybeCompilingFirstPassOfBlockWithInitialPushNil
	"For assert checking; or rather for avoiding assert fails when dealing with the hack for block temps in the SqueakV3PlusClosures bytecode set."
	^inBlock = InVanillaBlock and: [methodOrBlockNumTemps > methodOrBlockNumArgs and: [blockPass = 1]]