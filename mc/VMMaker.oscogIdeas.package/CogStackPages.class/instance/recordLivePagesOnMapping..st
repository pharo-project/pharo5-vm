statistics
recordLivePagesOnMapping: numLivePages
	<inline: true>
	statNumMaps := statNumMaps + 1.
	statPageCountWhenMappingSum := statPageCountWhenMappingSum + numLivePages.
	statMaxPageCountWhenMapping := statMaxPageCountWhenMapping max: numLivePages