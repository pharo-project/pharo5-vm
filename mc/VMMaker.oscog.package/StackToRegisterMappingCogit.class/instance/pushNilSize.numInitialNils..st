span functions
pushNilSize: aMethodObj numInitialNils: numInitialNils
	<inline: true>
	^self perform: pushNilSizeFunction with: aMethodObj with: numInitialNils