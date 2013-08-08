combination rules
pixMask: sourceWord with: destinationWord
	<inline: false>
	^ self partitionedAND: sourceWord bitInvert32 to: destinationWord
					nBits: destDepth nPartitions: destPPW