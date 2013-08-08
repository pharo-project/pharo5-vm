as yet unclassified
processThirdpartyLibraries

	config thirdpartyLibs do: [:each |
		each generateFor: self ]

