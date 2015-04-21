method map
JumpFullRT: callTarget
	"Big assumption here that calls and jumps look the same as regards their displacement.
	 This works on at least x86, ARM and x86_64.
	 JumpFull is intended to be for jumps anywhere in our address space.
	 See also JumpLong et al. which jump within our *code* space"
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^backEnd fullCallsAreRelative
		ifTrue: [self annotateCall: (self JumpFull: callTarget)]
		ifFalse: [self JumpFull: callTarget]