private-accessing
filesForPackage: package in: aDirectory
	"Names sorted from lowest version to highest"
	^((aDirectory fileNames
			select:
				[:fileName|
				(fileName beginsWith: package name)
				 and: [(fileName at: package name size + 1) isLetter not
				 and: [(fileName copyFrom: package name size + 2 to: package name size + 5) ~= 'spur']]]
			thenCollect: [:fn| {fn asMCVersionName versionNumber. fn}])
		sort: [:tuple :tupolev|
			tuple first < tupolev first
			or: [tuple first = tupolev first
				and: [tuple last < tupolev last]]])
		collect: [:tuple| tuple last]