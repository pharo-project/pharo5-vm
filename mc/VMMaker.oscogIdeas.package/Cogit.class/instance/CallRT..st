method map
CallRT: callTarget
	"Big assumption here that calls and jumps look the same as regards their displacement.
	 This works on at least x86, ARM and x86_64."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self annotateCall: (self Call: callTarget)