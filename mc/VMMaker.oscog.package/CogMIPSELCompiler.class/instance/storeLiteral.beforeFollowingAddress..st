inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the long constant loaded by a MoveCwR or PushCwR before the given address"
	| lastOpcode lastFunction oriAddress |
	self flag: #bogus. "The caller ought to know what it is patching, and this should be split into separate methods with stricter checking."
	
	lastOpcode := self opcodeAtAddress: followingAddress - 4.
	lastFunction := self functionAtAddress: followingAddress - 4.
	oriAddress := 0.
	lastOpcode = ORI ifTrue: [oriAddress := followingAddress - 4].
	lastOpcode = ADDIU ifTrue: [oriAddress := followingAddress - 16].
	lastOpcode = SPECIAL ifTrue: [lastFunction = SUBU ifTrue: [oriAddress := followingAddress - 8]].
	self assert: oriAddress ~= 0.
	^self literalAtAddress: oriAddress put: literal