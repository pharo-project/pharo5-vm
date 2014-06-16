instance creation
wordSize: bytesPerWord cog: cogRequired

	^(self wordSize: bytesPerWord)
		setClosureSupportRequirement: cogRequired;
		setCogSupportRequirement: cogRequired
