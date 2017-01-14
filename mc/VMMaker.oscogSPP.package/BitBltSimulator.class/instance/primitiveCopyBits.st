primitives
primitiveCopyBits
	"Override to provide a convenience to investigate primitive failures.
	 Comment out the first statement to be able to loop, examining e.g. why a BitBlt fails to load."
	true ifTrue:
		[^super primitiveCopyBits].
	[super primitiveCopyBits.
	 interpreterProxy failed] whileTrue:
		[self halt. interpreterProxy coInterpreter initPrimCall]