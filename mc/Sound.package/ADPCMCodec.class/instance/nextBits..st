bit streaming
nextBits: n
	"Answer the next n bits of my bit stream as an unsigned integer."

	<inline: true>

	| result remaining shift |

	result := 0.
	remaining := n.
	[true] whileTrue: [
		shift := remaining - bitPosition.
		result := result + (currentByte bitShift: shift).
		shift > 0
			ifTrue: [  "consumed currentByte buffer; fetch next byte"
				remaining := remaining - bitPosition.			
				currentByte := (encodedBytes at: (byteIndex := byteIndex + 1)).
				bitPosition := 8]
			ifFalse: [  "still some bits left in currentByte buffer"
				bitPosition := bitPosition - remaining.
				"mask out the consumed bits:"
				currentByte := currentByte bitAnd: (255 bitShift: (bitPosition - 8)).
				^ result]].
