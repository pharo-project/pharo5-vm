repository population
uploadFrom: localRepo to: uploadRepository
	localRepo allVersionsDo:
		[:version|
		(uploadRepository includesVersionNamed: version info name) ifFalse:
			[uploadRepository storeVersion: version]]