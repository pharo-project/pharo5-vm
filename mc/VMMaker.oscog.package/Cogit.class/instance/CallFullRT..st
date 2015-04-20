method map
CallFullRT: callTarget
	"Big assumption here that calls and jumps look the same as regards their displacement.
	 This works on at least x86, ARM and x86_64.
	 CallFull is intended to be for calls anywhere in our address space.
	 See also Call which calls within our *code* space"
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self annotateCall: (self CallFull: callTarget)