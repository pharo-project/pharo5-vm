bytecode generator support
maybeInlineSendOf: selectorIndex numArgs: numArgs receiverTags: rcvrTag
	"Allow the objectRepresentation to inline certain self-sends to immediates if it can.
	 We try and inline self asInteger in Character.  We assume this is not a special selector."
	<inline: true>
	| methodOrNil |
	(rcvrTag = objectMemory characterTag
	and: [numArgs = 0
	and: [selectorIndex >= 0
	and: [cogit ssTop isSameEntryAs: (self addressOf: cogit simSelf)]]]) ifFalse:
		[^false].

	methodOrNil := coInterpreter
						lookupSelector: (cogit getLiteral: selectorIndex)
						inClass: objectMemory classCharacter.
	(methodOrNil notNil
	 and: [(objectMemory isOopCompiledMethod: methodOrNil)
	 and: [(coInterpreter primitiveIndexOf: methodOrNil) = 171]]) ifFalse:
		[^false].

	cogit ssTop popToReg: ReceiverResultReg.
	self genConvertCharacterToSmallIntegerInReg: ReceiverResultReg.
	cogit ssTop type: SSRegister; register: ReceiverResultReg.
	^true