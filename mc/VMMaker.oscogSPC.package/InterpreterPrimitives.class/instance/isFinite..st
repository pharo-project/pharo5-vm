primitive support
isFinite: aDouble
	<var: #aDouble type: #double>
	<inline: true>
	^aDouble - aDouble = 0.0