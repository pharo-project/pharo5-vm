casting support
firstIndexableField: obj as: cType
	<inline: true>
	^interpreterProxy cCoerce: (interpreterProxy firstIndexableField: obj) to: cType