translation
pluginClassesUpToRoot
	"Answer the classes to include for translation of aPluginClass, superclasses first, and the root (VMClass in general, possibly Object)  last."
	| theClass classes |

	classes := OrderedCollection new.
	theClass := self.
	[theClass == Object
	 or: [theClass == VMClass]] whileFalse:
		[classes addLast: theClass.
		theClass := theClass superclass].
	^classes reverse