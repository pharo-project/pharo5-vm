combination rules
rgbAdd: sourceWord with: destinationWord
	<inline: false>
	<returnTypeC: 'unsigned int'>
	<var: #sourceWord type: 'unsigned int'>
	<var: #destinationWord type: 'unsigned int'>
	<var: #carryOverflowMask type: 'unsigned int'>
	<var: #componentMask type: 'unsigned int'>
	| componentMask carryOverflowMask |
	destDepth < 16 ifTrue:
		["Add each pixel separately"
		componentMask := 1<<destDepth-1.
		carryOverflowMask := 16rFFFFFFFF//componentMask<<(destDepth-1).
		^ self partitionedAdd: sourceWord to: destinationWord
						nBits: destDepth componentMask: componentMask carryOverflowMask: carryOverflowMask].
	destDepth = 16 ifTrue:
		["Add RGB components of each pixel separately"
		componentMask := 16r1F.
		carryOverflowMask := 16r42104210.
		^ (self partitionedAdd: (sourceWord bitAnd: 16r7FFF7FFF) to: (destinationWord bitAnd: 16r7FFF7FFF) "make sure that the unused bit is at 0"
						nBits: 5 componentMask: componentMask carryOverflowMask: carryOverflowMask)]
	ifFalse:
		["Add RGBA components of the pixel separately"
		componentMask := 16rFF.
		carryOverflowMask := 16r80808080.
		^ self partitionedAdd: sourceWord to: destinationWord
						nBits: 8 componentMask: componentMask carryOverflowMask: carryOverflowMask]