bootstrap methods
replacementForCharacterMethod: characterMethodOop
	"Answer a replacement method for the argument if it refers
	 to Character's old inst var value.  Otherwise answer nil."
	| proxy asIntegerProxy clone assembly newInsts newMethod |
	"(oldHeap stringOf: (oldHeap longAt: characterMethodOop + (oldHeap lastPointerOf: characterMethodOop) - 4)) = 'isOctetCharacter' ifTrue:
		[self halt]."
	"Don't replace something already installed."
	(installedMethodOops includes: characterMethodOop) ifTrue:
		[^nil].
	proxy := VMCompiledMethodProxy new
				for: characterMethodOop
				coInterpreter: oldInterpreter
				objectMemory: oldHeap.
	self assert: (oldHeap literalCountOf: characterMethodOop) = proxy numLiterals.
	clone := self cloneMethodProxy: proxy.
	self assert: proxy numLiterals = clone numLiterals.
	clone isReturnSpecial ifTrue:
		[^nil].
	"Quick methods accessing value should have been replaced.  The halt will fire if there
	 is a missing prototype for such a method on the class side of SpurBootstrap.  The
	 relevant Character prototypes there so far are Character>>asInteger, Character>>
	 asciiValue, Character>>hash & Character>>identityHash.  Conceivably the bootstrap
	 could be applied to an image that has others; hence the halt."
	clone isReturnField ifTrue: [self halt].
	clone hasInstVarRef ifFalse:
		[^nil].
	clone setSourcePointer: 0.
	asIntegerProxy := VMObjectProxy new
							for: (literalMap at: #asInteger)
							coInterpreter: oldInterpreter
							objectMemory: oldHeap.
	assembly := BytecodeDisassembler new disassemble: clone.
	assembly literals: (assembly literals allButLast: 2), {asIntegerProxy}, (assembly literals last: 2).
		"Do this by looking for index of pushReceiverVariable: and replacing it by pushSelf, send asInteger"
	newInsts := (assembly instructions piecesCutWhere:
					[:msgOrLabelAssoc :nextInst|
					 msgOrLabelAssoc isVariableBinding not
					 and: [msgOrLabelAssoc selector == #pushReceiverVariable:]]) fold:
				[:a :b|
				 a allButLast,
				 {	Message selector: #pushReceiver.
					Message
						selector: #send:super:numArgs:
						arguments: {asIntegerProxy. false. 0}},
				 b].
	assembly instructions: newInsts.
	newMethod := assembly assemble.
	self assert: clone numLiterals + 1 = newMethod numLiterals.
	^self
		installableMethodFor: newMethod
		selector: clone selector
		className: #Character
		isMeta: false