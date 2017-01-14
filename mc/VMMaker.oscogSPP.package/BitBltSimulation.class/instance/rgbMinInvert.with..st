combination rules
rgbMinInvert: wordToInvert with: destinationWord
	| sourceWord |
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #wordToInvert type: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	sourceWord := wordToInvert bitInvert32.
	destDepth < 16 ifTrue:
		["Min each pixel separately"
		^ self partitionedMin: sourceWord with: destinationWord
						nBits: destDepth nPartitions: destPPW].
	destDepth = 16 ifTrue:
		["Min RGB components of each pixel separately"
		^ (self partitionedMin: sourceWord with: destinationWord
						nBits: 5 nPartitions: 3)
		+ ((self partitionedMin: sourceWord>>16 with: destinationWord>>16
						nBits: 5 nPartitions: 3) << 16)]
	ifFalse:
		["Min RGBA components of the pixel separately"
		^ self partitionedMin: sourceWord with: destinationWord
						nBits: 8 nPartitions: 4]