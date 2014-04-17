Author 
	useAuthor: 'LoadVMMaker'
	during: [
		Gofer new
      		url: 'http://ss3.gemstone.com/ss/FileTree';
			package: 'ConfigurationOfFileTree';
			load.
		(Smalltalk at: #ConfigurationOfFileTree) load.

		Gofer new
			repository: (MCFileTreeRepository new 
				directory: '../mc' asFileReference;
				yourself);
			package: 'ConfigurationOfCog';
			load.	
		(Smalltalk at: #ConfigurationOfCog) loadGit.

		(Smalltalk saveAs: 'generator') 
			ifFalse: [ Smalltalk snapshot: false andQuit: true ] ].
