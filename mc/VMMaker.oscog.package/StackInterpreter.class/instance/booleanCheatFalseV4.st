utilities
booleanCheatFalseV4
	"cheat the interpreter out of the pleasure of handling the next bytecode IFF it is a jump-on-boolean. Which it is, often enough when the current bytecode is something like bytecodePrimEqual"
	<sharedCodeInCase: #bytecodePrimGreaterThanV4>
	| bytecode offset |

	bytecode := self fetchByte.  "assume next bytecode is jumpIfFalse (99%)"
	self internalPop: 2.
	(bytecode < 216 and: [bytecode > 207]) ifTrue:  "short jumpIfFalse"
		[^self jump: bytecode - 207].

	bytecode = 244 ifTrue:  "long jumpIfFalse"
		[offset := self fetchByte.
		^self jump: offset].

	"not followed by a jumpIfFalse; (un)do instruction fetch and push boolean result"
	self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [currentBytecode := bytecode + bytecodeSetSelector]
		ifFalse: [currentBytecode := bytecode].
	self internalPush: objectMemory falseObject