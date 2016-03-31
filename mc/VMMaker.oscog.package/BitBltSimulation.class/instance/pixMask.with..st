combination rules
pixMask: sourceWord with: destinationWord
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	^ self partitionedAND: sourceWord bitInvert32 to: destinationWord
					nBits: destDepth nPartitions: destPPW