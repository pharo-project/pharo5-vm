instance creation
wordSize: bytesPerWord spur: spurRequired
	"Answer a Spur image format, or default to Cog if Spur is not specified"

	^(self wordSize: bytesPerWord)
		setClosureSupportRequirement: true;
		setCogSupportRequirement: true;
		setSpurSupportRequirement: spurRequired
