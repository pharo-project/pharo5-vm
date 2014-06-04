private-support
isAlien: anOop
	<export: true>
	^interpreterProxy
		includesBehavior: (interpreterProxy fetchClassOf: anOop)
		ThatOf: interpreterProxy classAlien