instance creation
wordSize: bytesPerWord spur: spurRequired requiresNewSpur64TagAssignment: newSpur64
	"Answer a Spur image format, or default to Cog if Spur is not specified"

	^(self wordSize: bytesPerWord)
		setClosureSupportRequirement: true;
		setCogSupportRequirement: true;
		setSpurSupportRequirement: spurRequired;
		setRequiresNewSpur64TagAssignmentRequirement: newSpur64
