method map
CallRT: callTarget
	"Big assumption here that calls and jumps look the same as regards their displacement.
	 This works on x86 and I think on ARM."
	<inline: true>
	<returnTypeC: #'AbstractInstruction *'>
	^self annotateCall: (self Call: callTarget)