inlining
initializerForInstVar: varName inStartClass: aClass
	| allClasses sizeBefore |
	(aClass inheritsFrom: VMClass) ifFalse:
		[^false].
	allClasses := (aClass withAllSuperclasses copyUpTo: VMClass) asSet.
	[sizeBefore := allClasses size.
	 allClasses copy do:
		[:class|
		(class ancilliaryClasses: optionsDictionary) do:
			[:ancilliary|
			allClasses addAll: (ancilliary withAllSuperclasses copyUpTo: VMClass)]].
	 sizeBefore ~= allClasses size] whileTrue.
	allClasses do:
		[:class|
		(self initializerForInstVar: varName in: class) ifNotNil:
			[:initializer| ^initializer]].
	^nil