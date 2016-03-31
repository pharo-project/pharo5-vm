combination rules
rgbMax: sourceWord with: destinationWord
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	destDepth < 16 ifTrue:
		["Max each pixel separately"
		^ self partitionedMax: sourceWord with: destinationWord
						nBits: destDepth nPartitions: destPPW].
	destDepth = 16 ifTrue:
		["Max RGB components of each pixel separately"
		^ (self partitionedMax: sourceWord with: destinationWord
						nBits: 5 nPartitions: 3)
		+ ((self partitionedMax: sourceWord>>16 with: destinationWord>>16
						nBits: 5 nPartitions: 3) << 16)]
	ifFalse:
		["Max RGBA components of the pixel separately"
		^ self partitionedMax: sourceWord with: destinationWord
						nBits: 8 nPartitions: 4]