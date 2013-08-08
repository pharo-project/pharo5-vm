combination rules
pixPaint: sourceWord with: destinationWord
	<inline: false>
	sourceWord = 0 ifTrue: [^ destinationWord].
	^ sourceWord bitOr:
		(self partitionedAND: sourceWord bitInvert32 to: destinationWord
						nBits: destDepth nPartitions: destPPW)