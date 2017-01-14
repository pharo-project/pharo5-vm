object memory support
checkCodeIntegrity: gcModes
	"Perform an integrity/leak check using the heapMap.  Assume
	 clearLeakMapAndMapAccessibleObjects has set a bit at each
	 object's header.  Check that all object references in machine
	 code are valid.  Answer if all checks pass."
	^cogit checkIntegrityOfObjectReferencesInCode: gcModes