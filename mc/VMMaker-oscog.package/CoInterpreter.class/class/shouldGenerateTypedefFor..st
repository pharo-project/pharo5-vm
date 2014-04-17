translation
shouldGenerateTypedefFor: aStructClass
	"Hack to work-around multiple definitions.  Sometimes a type has been defined in an include."
	^({ CogBlockMethod. CogMethod. SistaCogMethod } includes: aStructClass) not