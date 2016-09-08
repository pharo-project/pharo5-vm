primitive support
signalNoResume: aSemaphore
	"Signal the given semaphore from within the interpreter.  Used to serialize callbacks."
	| empty |
	<api>
	<inline: false>
	empty := self isEmptyList: aSemaphore. 
	empty ifFalse:
		[self putToSleep: (self removeFirstLinkOfList: aSemaphore) yieldingIf: true].
	^empty