bytecode generator support
genGetActiveContextNumArgs: numArgs large: isLargeContext inBlock: isInBlock
	"Get the active context into ReceiverResultReg, creating it if necessary."
	| routine |
	routine := isLargeContext
				ifFalse: [isInBlock caseOf: {
						[0]				-> [ceSmallActiveContextInMethodTrampoline].
						[InVanillaBlock]	-> [ceSmallActiveContextInBlockTrampoline].
						[InFullBlock]	-> [ceSmallActiveContextInFullBlockTrampoline] }]
				ifTrue: [isInBlock caseOf: {
						[0]				-> [ceLargeActiveContextInMethodTrampoline].
						[InVanillaBlock]	-> [ceLargeActiveContextInBlockTrampoline].
						[InFullBlock]	-> [ceLargeActiveContextInFullBlockTrampoline] }].
	cogit
		MoveCq: numArgs R: SendNumArgsReg;
		CallRT: routine.
	^0