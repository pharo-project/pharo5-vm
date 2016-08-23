send bytecodes
shuffleArgumentsAndStoreAbsentReceiver: theReceiver
	"For the absent receiver sends move the arguments up the stack and store the supplied receiver."
	<inline: true>
	localSP := localSP - objectMemory bytesPerOop. "a.k.a. self internalPush: anything"
	1 to: argumentCount do:
		[:i| | oop |
		oop := self internalStackValue: i.
		self internalStackValue: i - 1 put: oop].
	self internalStackValue: argumentCount put: theReceiver