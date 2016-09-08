rcvr linkage
rcvrPCREBufferPtr
	<inline: true>
	^self
		cCoerce: (interpreterProxy fetchArray: 2 ofObject: rcvr)
		to: #sqInt