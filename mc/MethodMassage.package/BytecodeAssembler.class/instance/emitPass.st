assembly
emitPass
	| literals nLits emitter |

	literals := encoder allLiterals.
	nLits := literals size.
	emitter := BytecodeEmitter assembler: self encoder: encoder.

	1 to: nLits do: [:lit | method literalAt: lit put: (literals at: lit)].

	encoder streamToMethod: method.

	code instructions withIndexDo:
		[:messageOrLabel :i|
		(self isLabel: messageOrLabel) ifFalse:
			[index := i.
			 messageOrLabel sentTo: emitter]].

	"Need to create distinct literals for all literals in the method
	 *except* variable bindings and the methodClass literal.."
	1 to: method numLiterals - 2 do:
		[:litIndex| | lit |
		lit := method literalAt: litIndex.
		lit isVariableBinding ifFalse:
			[method
				literalAt: litIndex
				put: (lit isArray ifTrue: [lit deepCopy] ifFalse: [lit copy])]].

	"Need to create a distinct additional method state if it has one.
	 Avoid setting selector if already set (method penultimateLiteral notNil and not a metod properties)"
	method penultimateLiteral
		ifNil: [method selector: code selector]
		ifNotNil:
			[:plit|
			plit isMethodProperties ifTrue:
				[method
					penultimateLiteral: plit copy;
					selector: code selector]]
	