source files
standardIncludes
	^ #(
	'${crossDir}/plugins/SerialPlugin'   
	'${targetPlatform}/plugins/FilePlugin'
	'${crossDir}/plugins/FilePlugin'
	'${targetPlatform}/plugins/HostWindowPlugin'
	'${platformsDir}/iOS/vm/iPhone/plugins/HostWindowPlugin' 
	'${crossDir}/plugins/HostWindowPlugin'
	'${crossDir}/plugins/DropPlugin'
	'${crossDir}/plugins/SocketPlugin'
	'${crossDir}/plugins/SoundPlugin'
	'${crossDir}/plugins/AsynchFilePlugin'
	'${platformsDir}/unix/vm'
	'${platformsDir}/iOS/plugins/SoundPlugin'
	'${platformsDir}/iOS/vm/OSX/plugins/SoundPlugin'
	'${platformsDir}/iOS/vm/Common/Classes'
	'${platformsDir}/iOS/vm/OSX'
)
	