fills-bitmaps
repeatValue: delta max: maxValue
	| newDelta |
	<inline: true>
	newDelta := delta.
	[newDelta < 0] whileTrue:[newDelta := newDelta + maxValue].
	[newDelta >= maxValue] whileTrue:[newDelta := newDelta - maxValue].
	^newDelta