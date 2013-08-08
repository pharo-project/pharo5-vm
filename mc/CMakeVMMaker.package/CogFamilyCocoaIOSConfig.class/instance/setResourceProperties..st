settings
setResourceProperties: maker
	maker set: 'resourceDir' toString: self resourcesDir, '/ProjectBuilder'.

	maker 
		set: 'resources' 
		to: (String streamContents: [ :stream | 
			self  resources
				do: [ :each | 
					stream 
						nextPut: $";
						nextPutAll: '${resourceDir}/';
						nextPutAll: each;
						nextPut: $"]
				separatedBy: [ stream space ] ]).
		
	maker 
		set: 'resourcesLocaleEnglish' 
		to: '"${resourceDir}/English.lproj/InfoPlist.strings" "${resourceDir}/English.lproj/MainMenu.nib"'.

	maker 
		cmd: 'set_source_files_properties' 
		params: '${resources} PROPERTIES MACOSX_PACKAGE_LOCATION Resources'.

	maker 
		cmd: 'set_source_files_properties' 
		params: '${resourcesLocaleEnglish} PROPERTIES MACOSX_PACKAGE_LOCATION Resources/English.lproj'.

