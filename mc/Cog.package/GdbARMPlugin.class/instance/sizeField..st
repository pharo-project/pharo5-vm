alien support
sizeField: rcvr
	"Answer the first field of rcvr which is assumed to be an Alien of at least 8 bytes"
	<inline: true>
	^self longAt: rcvr + interpreterProxy baseHeaderSize