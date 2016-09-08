combination rules
rgbSub: sourceWord with: destinationWord
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	destDepth < 16 ifTrue:
		["Sub each pixel separately"
		^ self partitionedSub: sourceWord from: destinationWord
						nBits: destDepth nPartitions: destPPW].
	destDepth = 16 ifTrue:
		["Sub RGB components of each pixel separately"
		^ (self partitionedSub: sourceWord from: destinationWord
						nBits: 5 nPartitions: 3)
		+ ((self partitionedSub: sourceWord>>16 from: destinationWord>>16
						nBits: 5 nPartitions: 3) << 16)]
	ifFalse:
		["Sub RGBA components of the pixel separately"
		^ self partitionedSub: sourceWord from: destinationWord
						nBits: 8 nPartitions: 4]