tests support
coverTestBasicBlockLabelsForMethod

	(PackageOrganizer default packageOfClass: self class) actualMethodsDo:
		[:m| self testBasicBlockLabelsFor: m]