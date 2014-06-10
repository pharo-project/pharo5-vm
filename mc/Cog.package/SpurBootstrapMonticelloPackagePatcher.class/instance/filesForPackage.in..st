private-accessing
filesForPackage: package in: aDirectory
	^aDirectory fileNames select:
		[:fileName|
		(fileName beginsWith: package name)
		 and: [(fileName at: package name size + 1) isLetter not]]