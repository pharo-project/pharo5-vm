process primitive support
internalQuickCheckForInterrupts
	"Internal version of quickCheckForInterrupts for use within jumps."

	<inline: true>
	<asmLabel: true> 
	statQuickCheckForEvents := statQuickCheckForEvents + 1.
	((interruptCheckCounter := interruptCheckCounter - 1) <= 0) ifTrue: [
		self externalizeIPandSP.
		self checkForInterrupts.

		self browserPluginReturnIfNeeded.

		self internalizeIPandSP]