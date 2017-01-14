testing
extractOffsetFromBL: instr
	"we are told this is a BL <offset> instruction, so work out the offset it encodes"
	<inline: true>
	| relativeJump |
	relativeJump := instr bitAnd: 16r00FFFFFF.
	relativeJump := (relativeJump anyMask: 1<<23)
						ifTrue: [((relativeJump bitOr: 16r3F000000) << 2) signedIntFromLong]
						ifFalse: [relativeJump << 2].
	^relativeJump