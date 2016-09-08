utilities
booleanCheatTrue
	"cheat the interpreter out of the pleasure of handling the next bytecode IFF it is a jump-on-boolean. Which it is, often enough when the current bytecode is something like bytecodePrimEqual"
	<sharedCodeInCase: #bytecodePrimLessThan>
	| bytecode offset |

	bytecode := self fetchByte.  "assume next bytecode is jumpIfFalse (99%)"
	self internalPop: 2.
	(bytecode < 173 and: [bytecode > 151]) ifTrue:
		[bytecode < 160 ifTrue: "short jumpIfFalse 152 - 159"
			[^self fetchNextBytecode].
		bytecode = 172 ifTrue: "long jumpIfFalse"
			[self fetchByte.
			^self fetchNextBytecode].
		bytecode > 167 ifTrue: "long jumpIfTrue 168 - 171"
			[offset := bytecode - 168 << 8 + self fetchByte.
			^self jump: offset]].

	"not followed by a jumpIfFalse; (un)do instruction fetch and push boolean result"
	self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [currentBytecode := bytecode + bytecodeSetSelector]
		ifFalse: [currentBytecode := bytecode].
	self internalPush: objectMemory trueObject