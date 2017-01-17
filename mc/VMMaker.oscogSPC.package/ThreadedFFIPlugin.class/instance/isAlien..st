primitive support
isAlien: anOop
	^interpreterProxy
		includesBehavior: (interpreterProxy fetchClassOf: anOop)
		ThatOf: interpreterProxy classAlien