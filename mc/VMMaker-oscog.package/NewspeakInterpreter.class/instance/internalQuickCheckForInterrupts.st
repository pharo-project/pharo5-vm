processes
internalQuickCheckForInterrupts
	"Internal version of quickCheckForInterrupts for use within jumps."

	<inline: true>
	((interruptCheckCounter := interruptCheckCounter - 1) <= 0) ifTrue: [
		self externalizeIPandSP.
		self checkForInterrupts.

		self browserPluginReturnIfNeeded.

		self internalizeIPandSP].
