header access
isContextHeader: aHeader
	<inline: true>
	^(self classIndexOfHeader: aHeader) = ClassMethodContextCompactIndex