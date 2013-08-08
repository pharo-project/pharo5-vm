bit streaming
nextBits: n put: anInteger
	"Write the next n bits to my bit stream."

	<inline: true>

	| buf bufBits bitsAvailable shift |

	buf := anInteger.
	bufBits := n.
	[true] whileTrue: [
		bitsAvailable := 8 - bitPosition.
		shift := bitsAvailable - bufBits.  "either left or right shift"
		"append high bits of buf to end of currentByte:"
		currentByte := currentByte + (buf bitShift: shift).
		shift < 0
			ifTrue: [  "currentByte buffer filled; output it"
				encodedBytes at: (byteIndex := byteIndex + 1) put: currentByte.
				bitPosition := 0.
				currentByte := 0.
				"clear saved high bits of buf:"
				buf := buf bitAnd: (1 bitShift: 0 - shift) - 1.
				bufBits := bufBits - bitsAvailable]
			ifFalse: [  "still some bits available in currentByte buffer"
				bitPosition := bitPosition + bufBits.
				^ self]].
