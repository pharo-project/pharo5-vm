generating actions
copyArtefacts

	gen puts:
'add_custom_command(
	OUTPUT "${externalModulesDir}/${libraryFileName}"
	COMMAND cp ${libpngInstalled} ${externalModulesDir}/${libraryFileName}
	DEPENDS "${libpngInstalled}"
)'