primitive support
sizeField: oop
	"Answer the first field of oop which is assumed to be an Alien of at least 8 bytes"
	<inline: true>
	^self longAt: oop + interpreterProxy baseHeaderSize