translation
buildCodeGenerator
	"Build a CCodeGenerator for the plugin"
	| cg pluginClasses |
	cg := self codeGeneratorClass new initialize.
	cg pluginClass: self.
	(pluginClasses := self pluginClassesUpToRoot) do:
		[:aClass| cg addClass: aClass].
	(cg structClassesForTranslationClasses: pluginClasses) do:
		[:structClasss| cg addStructClass: structClasss].
	cg addMethodsForTranslatedPrimitives: self translatedPrimitives.
	^cg