cleanup obsolete classes
cleanupClassHierarchy: informer
	"Makes the class hierarchy consistent and removes obsolete classes from the SystemDictionary."
	| classes |
	self crTrace: 'Start fixing the class hierarchy and cleaning up...'.
	Smalltalk garbageCollect.
	classes := Metaclass allInstances.
	classes keysAndValuesDo: [:index :meta |
		informer label: 'Fixing  class hierarchy ', (index * 100 // classes size) printString, '%'.
		"Check classes before metaclasses (because Metaclass>>isObsolete
		checks whether the related class is obsolete)"
		meta allInstances do: [:each | self cleanupClassHierarchyFor: each].
		self cleanupClassHierarchyFor: meta.
	].
	self traceCr: 'DONE'.