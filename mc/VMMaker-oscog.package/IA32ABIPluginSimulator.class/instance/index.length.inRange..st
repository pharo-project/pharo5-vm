private-support
index: byteIndex length: length inRange: rcvr
	"Answer if the indices byteIndex to byteIndex + length - 1 are valid zero-relative indices into the rcvr."
	| dataSize |
	<inline: true>
	dataSize := self sizeField: rcvr.
	^dataSize = 0 or: [byteIndex > 0 and: [byteIndex + length <= dataSize abs]]