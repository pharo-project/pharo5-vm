AET processing
removeFirstAETEntry
	| index |
	<inline: false>
	index := self aetStartGet.
	self aetUsedPut: self aetUsedGet - 1.
	[index < self aetUsedGet] whileTrue:[
		aetBuffer at: index put: (aetBuffer at: index + 1).
		index := index + 1.
	].