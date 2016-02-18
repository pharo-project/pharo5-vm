configurations
findOldestConfigurationFor: packageVersions inVersionNames: configurationVersionNames repository: repo
	| oldest |
	oldest := configurationVersionNames first.
	configurationVersionNames do:
		[:cfgver| | config |
		config := repo versionNamed: cfgver.
		(packageVersions noneSatisfy:
			[:pkgver| | configVersion |
			configVersion := config dependencies detect:
								[:dep|
								 pkgver packageName = dep package name].
			configVersion versionInfo versionNumber >= pkgver versionNumber]) ifTrue:
				[^oldest].
		oldest := cfgver].
	self error: 'couldn''t find configuration newer than supplied versions'