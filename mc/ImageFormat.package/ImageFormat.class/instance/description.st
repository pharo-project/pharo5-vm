printing
description

	"(ImageFormat fromInteger: 6502) description"

	^String streamContents: [:s | self printDescriptionOn: s]
