testing
extractOffsetFromBL: instr
"we are told this is a BL <offset> instruction, so work out the offset it encodes"
	| relativeJump |
	relativeJump := instr bitAnd: 16r00FFFFFF.
	relativeJump := (relativeJump bitAt: 24) = 1 
						ifTrue: [((relativeJump bitOr: 16r3F000000) << 2) signedIntFromLong]
						ifFalse: [relativeJump << 2].
	^relativeJump