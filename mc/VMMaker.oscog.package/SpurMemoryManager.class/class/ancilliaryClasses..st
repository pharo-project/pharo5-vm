translation
ancilliaryClasses: options
	initializationOptions ifNil: [initializationOptions := options].
	^{	SpurGenerationScavenger. SpurSegmentManager. SpurSegmentInfo. self compactorClass },
		SpurNewSpaceSpace withAllSubclasses