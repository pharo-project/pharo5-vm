translation
shouldBeTranslatedFor: platformName

	^platformName = 'Cross'
	  or: [self isResponsibleFor: platformName]