stack access
pop: nItems
	<returnTypeC: #sqInt>
	1 to: nItems do:[:i| stack removeLast].