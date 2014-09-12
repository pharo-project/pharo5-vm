method prototypes
CharacterPROTOTYPEshouldBePrintedAsLiteral

	^(self asInteger between: 33 and: 255) and: [self asInteger ~= 127]