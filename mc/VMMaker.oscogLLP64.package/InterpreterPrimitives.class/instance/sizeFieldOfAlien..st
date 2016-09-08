primitive support
sizeFieldOfAlien: alienObj
	"Answer the first field of alienObj which is assumed to be an Alien of at least 8 bytes"
	<inline: true>
	^self longAt: alienObj + objectMemory baseHeaderSize