utilities
booleanCheatTrueV4
	"cheat the interpreter out of the pleasure of handling the next bytecode IFF it is a jump-on-boolean. Which it is, often enough when the current bytecode is something like bytecodePrimEqual"
	<sharedCodeInCase: #bytecodePrimLessThanV4>
	| bytecode offset |

	bytecode := self fetchByte.  "assume next bytecode is jumpIfFalse (99%)"
	self internalPop: 2.
	bytecode >= 208 ifTrue:
		[bytecode <= 215 ifTrue: "short jumpIfFalse 208 - 215"
			[^self fetchNextBytecode].
		bytecode = 244 ifTrue: "long jumpIfFalse"
			[self fetchByte.
			^self fetchNextBytecode].
		bytecode = 243 ifTrue: "long jumpIfTrue 243"
			[offset := self fetchByte.
			^self jump: offset]].

	"not followed by a jumpIfFalse; (un)do instruction fetch and push boolean result"
	self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [currentBytecode := bytecode + bytecodeSetSelector]
		ifFalse: [currentBytecode := bytecode].
	self internalPush: objectMemory trueObject