translation
pluginClassesUpTo: aPluginClass
	"Answer the classes to include for translation of aPluginClass, superclasses first, aPluginClass last."
	| theClass classes |

	classes := OrderedCollection new.
	theClass := self.
	[theClass == Object
	 or: [theClass == VMClass]] whileFalse:
		[classes addLast: theClass.
		theClass := theClass superclass].
	^classes reverse