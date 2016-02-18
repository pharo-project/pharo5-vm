printing
nameForFPRegister: reg "<Integer>"
	<doNotGenerate>
	(reg between: 0 and: 15) ifTrue:
		[^#(XMM0L XMM1L XMM2L XMM3L XMM4L XMM5L XMM6L XMM7L XMM8L XMM9L XMM10L XMM11L XMM12L XMM13L XMM14L XMM15L) at: reg + 1].
	^super nameForFPRegister: reg