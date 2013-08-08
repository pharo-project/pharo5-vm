source files
standardIncludes
	^ #(
	'SYSTEM /Developer/Headers/FlatCarbon'
	'${targetPlatform}/vm/Developer'  "for some unknown reason sqGnu.h is put there"
	
	'${crossDir}/plugins/SerialPlugin'   "for platforms/Mac OS/vm/osExports.c to work"
	'${targetPlatform}/plugins/FilePlugin'   "for sqMacFileLogic.h to work"
	'${targetPlatform}/plugins/HostWindowPlugin'  "for sqMacNSPluginUILogic2.c to work"
	'${crossDir}/plugins/HostWindowPlugin' "for same... "
	'${crossDir}/plugins/DropPlugin' "include DropPlugin.h"
	'${crossDir}/plugins/SocketPlugin'
	'${crossDir}/plugins/AsynchFilePlugin'
	'${platformsDir}/unix/vm'  "suppressing following:
		platforms/Mac OS/vm/sqMacMain.c:94:19: error: sqaio.h: No such file or directory
		platforms/Mac OS/vm/sqMacMain.c:96:28: error: sqUnixCharConv.h: No such file or directory"
	)
	