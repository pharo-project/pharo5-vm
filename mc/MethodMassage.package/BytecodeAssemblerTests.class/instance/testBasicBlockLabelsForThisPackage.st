tests
testBasicBlockLabelsForThisPackage
	(PackageOrganizer default packageOfClass: self class) actualMethodsDo:
		[:m| self testBasicBlockLabelsFor: m]