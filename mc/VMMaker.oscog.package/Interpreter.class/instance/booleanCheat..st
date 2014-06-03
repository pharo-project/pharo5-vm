utilities
booleanCheat: cond
"cheat the interpreter out of the pleasure of handling the next bytecode IFF it is a jump-on-boolean. Which it is, often enough when the current bytecode is something like bytecodePrimEqual"
	| bytecode offset |
	<inline: true>

	bytecode := self fetchByte.  "assume next bytecode is jumpIfFalse (99%)"
	self internalPop: 2.
	(bytecode < 160 and: [bytecode > 151]) ifTrue: [  "short jumpIfFalse"
		cond
			ifTrue: [^ self fetchNextBytecode]
			ifFalse: [^ self jump: bytecode - 151]].

	bytecode = 172 ifTrue: [  "long jumpIfFalse"
		offset := self fetchByte.
		cond
			ifTrue: [^ self fetchNextBytecode]
			ifFalse: [^ self jump: offset]].

	"not followed by a jumpIfFalse; undo instruction fetch and push boolean result"
	localIP := localIP - 1.
	self fetchNextBytecode.
	cond
		ifTrue: [self internalPush: trueObj]
		ifFalse: [self internalPush: falseObj].
