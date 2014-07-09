tests
testAsAssemblerForThisPackage
	(PackageOrganizer default packageOfClass: self class) actualMethodsDo:
		[:m| self testAsAssemblerFor: m]