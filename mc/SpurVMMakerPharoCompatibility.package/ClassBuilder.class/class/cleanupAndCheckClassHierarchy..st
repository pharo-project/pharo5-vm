cleanup obsolete classes
cleanupAndCheckClassHierarchy: informer
	"Makes the class hierarchy consistent and removes obsolete classes from the SystemDictionary.
	Afterwards it checks whether the hierarchy is really consistent."

	self crTrace: '*** Before cleaning up ***'.
	self countReallyObsoleteClassesAndMetaclasses.
	self cleanupClassHierarchy: informer.
	self checkClassHierarchyConsistency: informer.
	self crTrace: ''; crTrace:  '*** After cleaning up ***'.
	self countReallyObsoleteClassesAndMetaclasses.