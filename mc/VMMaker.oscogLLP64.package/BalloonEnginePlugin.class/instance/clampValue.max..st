fills-bitmaps
clampValue: value max: maxValue

	<inline: true>
	value < 0 
		ifTrue:[^0]
		ifFalse:[value >= maxValue 
					ifTrue:[^maxValue-1]
					ifFalse:[^value]]