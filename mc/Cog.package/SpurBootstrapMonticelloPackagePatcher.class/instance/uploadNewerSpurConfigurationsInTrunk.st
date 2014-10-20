configurations
uploadNewerSpurConfigurationsInTrunk
	"Make sure that update.spur configurations exist for all relevant update.* configurations."
	"SpurBootstrapMonticelloPackagePatcher new uploadNewerSpurConfigurationsInTrunk"
	| trunk |
	trunk := self trunk.
	trunk cacheAllFileNamesDuring:
		[| configurations spurConfigurations oldestUpdate |
		 spurConfigurations := (trunk versionNamesForPackageNamed: 'update.spur') sort: [:a :b| a versionNumber > b versionNumber].
		 configurations := ((trunk versionNamesForPackageNamed: 'update') select: [:n| n beginsWith: 'update-']) sort: [:a :b| a versionNumber > b versionNumber].
		 oldestUpdate := spurConfigurations isEmpty
							ifTrue:
								[| earliestBranches earliestUnbranched  |
								 earliestBranches := self packages collect:
														[:package|
														(trunk versionNamesForPackageNamed: package name, '.spur') detectMin:
															[:vn | vn asMCVersionName versionNumber]].
								 earliestUnbranched := earliestBranches collect:
															[:verName| (verName copyReplaceAll: '.spur' with: '') asMCVersionName].
								 self
									findOldestConfigurationFor: earliestUnbranched
									inVersionNames: configurations
									repository: trunk]
							ifFalse:
								[spurConfigurations first copyReplaceAll: '.spur' with: ''].
		 Transcript nextPutAll: 'Oldest: ', oldestUpdate; cr; flush.
		 (configurations copyFrom: 1 to: (configurations indexOf: oldestUpdate) - 1) reverseDo:
			[:configName|
			 "((configName beginsWith: 'update-eem.29') and: ['34' includes: (configName at: 14)]) ifTrue:
				[self halt]."
			 (self spurConfigurationOf: (trunk versionNamed: configName) forRepository: trunk) ifNotNil:
				[:edition| trunk storeVersion: edition]]]