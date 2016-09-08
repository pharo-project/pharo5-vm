combination rules
rgbDiff: sourceWord with: destinationWord
	"Subract the pixels in the source and destination, color by color,
	and return the sum of the absolute value of all the differences.
	For non-rgb, return the number of differing pixels."
	| pixMask destShifted sourceShifted destPixVal bitsPerColor rgbMask sourcePixVal diff maskShifted |
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #sourceShifted type: 'unsigned int'>
	<var: #destShifted type: 'unsigned int'>
	<var: #maskShifted type: 'unsigned int'>
	<var: #pixMask type: 'unsigned int'>
	<var: #rgbMask type: 'unsigned int'>
	pixMask := maskTable at: destDepth.
	destDepth = 16
		ifTrue: [bitsPerColor := 5.  rgbMask := 16r1F]
		ifFalse: [bitsPerColor := 8.  rgbMask := 16rFF].
	maskShifted := destMask.
	destShifted := destinationWord.
	sourceShifted := sourceWord.
	1 to: destPPW do:
		[:i |
		(maskShifted bitAnd: pixMask) > 0 ifTrue:
			["Only tally pixels within the destination rectangle"
			destPixVal := destShifted bitAnd: pixMask.
			sourcePixVal := sourceShifted bitAnd: pixMask.
			destDepth < 16
				ifTrue: [sourcePixVal = destPixVal
							ifTrue: [diff := 0]
							ifFalse: [diff := 1]]
				ifFalse: [diff := (self partitionedSub: sourcePixVal from: destPixVal
								nBits: bitsPerColor nPartitions: 3).
						diff := (diff bitAnd: rgbMask)
							+ (diff>>bitsPerColor bitAnd: rgbMask)
							+ ((diff>>bitsPerColor)>>bitsPerColor bitAnd: rgbMask)].
			bitCount := bitCount + diff].
		maskShifted := maskShifted >> destDepth.
		sourceShifted := sourceShifted >> destDepth.
		destShifted := destShifted >> destDepth].
	^ destinationWord  "For no effect on dest"
