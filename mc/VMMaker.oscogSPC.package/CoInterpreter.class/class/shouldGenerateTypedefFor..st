translation
shouldGenerateTypedefFor: aStructClass
	"Hack to work-around multiple definitions.  Sometimes a type has been defined in an include."
	^(super shouldGenerateTypedefFor: aStructClass)
	  and: [Cogit shouldGenerateTypedefFor: aStructClass]