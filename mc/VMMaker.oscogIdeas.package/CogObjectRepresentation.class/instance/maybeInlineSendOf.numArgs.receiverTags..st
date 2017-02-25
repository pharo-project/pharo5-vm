bytecode generator support
maybeInlineSendOf: selectorIndex numArgs: numArgs receiverTags: rcvrTag
	"Allow the objectRepresentation to inline certain self-sends to immediates if it can."
	<inline: true>
	^false