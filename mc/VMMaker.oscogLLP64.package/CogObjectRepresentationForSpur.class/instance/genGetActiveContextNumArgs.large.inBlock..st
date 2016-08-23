bytecode generator support
genGetActiveContextNumArgs: numArgs large: isLargeContext inBlock: isInBlock
	"Get the active context into ReceiverResultReg, creating it if necessary."
	| routine |
	routine := isLargeContext
				ifFalse: [isInBlock
							ifFalse: [ceSmallActiveContextInMethodTrampoline]
							ifTrue: [ceSmallActiveContextInBlockTrampoline]]
				ifTrue: [isInBlock
							ifFalse: [ceLargeActiveContextInMethodTrampoline]
							ifTrue: [ceLargeActiveContextInBlockTrampoline]].
	cogit
		MoveCq: numArgs R: SendNumArgsReg;
		CallRT: routine.
	^0