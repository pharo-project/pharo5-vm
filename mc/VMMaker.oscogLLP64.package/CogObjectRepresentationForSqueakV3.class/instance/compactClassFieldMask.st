object representation
compactClassFieldMask
	"This is the mask for the field when shifted into the least significant bits"
	<inline: true>
	^(1 << objectMemory compactClassFieldWidth) - 1