rcvr linkage
rcvrMatchSpacePtr

	<inline: true>
	<returnTypeC: 'int *'>
	^self
		cCoerce: (interpreterProxy fetchArray: 7 ofObject: rcvr)
		to: 'int *'.