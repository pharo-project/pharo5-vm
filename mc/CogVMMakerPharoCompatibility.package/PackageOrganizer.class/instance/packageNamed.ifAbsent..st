accessing
packageNamed: packageName ifAbsent: aBlock
	^ RPackageOrganizer default 
		packageNamed: packageName
		ifAbsent: aBlock