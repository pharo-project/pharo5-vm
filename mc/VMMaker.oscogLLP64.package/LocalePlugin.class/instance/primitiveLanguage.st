system primitives
primitiveLanguage
	"return a 3 char string describing the language in use. ISO 639 is the relevant source here; see http://www.w3.org/WAI/ER/IG/ert/iso639.html for details"
	| oop |
	self primitive:'primitiveLanguage'.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: 3.
	self sqLocGetLanguageInto: (interpreterProxy firstIndexableField: oop).
	^oop
