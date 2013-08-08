translation
buildCodeGeneratorUpTo: aPluginClass
	"Build a CCodeGenerator for the plugin"
	| cg pluginClasses |
	cg := self codeGeneratorClass new initialize.
	cg pluginClass: self.
	(pluginClasses := self pluginClassesUpTo: aPluginClass) do:
		[:aClass| cg addClass: aClass].
	(cg structClassesForTranslationClasses: pluginClasses) do:
		[:structClasss| cg addStructClass: structClasss].
	cg removeUnneededBuiltins.
	^cg