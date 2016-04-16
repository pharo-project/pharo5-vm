util
isLargeIntegerOop: oop
	| oopClass |
	oopClass := interpreterProxy fetchClassOf: oop.
	^oopClass == interpreterProxy classLargeNegativeInteger or: [oopClass == interpreterProxy classLargePositiveInteger]