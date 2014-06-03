translation
ancilliaryClasses: options
	initializationOptions ifNil:
		[initializationOptions := options].
	^(super ancilliaryClasses: options), (self objectRepresentationClass withAllSuperclasses copyUpThrough: CogObjectRepresentation) reverse