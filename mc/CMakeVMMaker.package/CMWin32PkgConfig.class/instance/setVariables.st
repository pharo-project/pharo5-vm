as yet unclassified
setVariables

	super setVariables.
	
	gen set: #pkgConfigBinary toString: '${installPrefix}/bin/pkg-config.exe'