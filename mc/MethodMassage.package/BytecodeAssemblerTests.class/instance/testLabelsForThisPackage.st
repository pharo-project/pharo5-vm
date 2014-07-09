tests
testLabelsForThisPackage
	(PackageOrganizer default packageOfClass: self class) actualMethodsDo:
		[:m| self testLabelsFor: m]