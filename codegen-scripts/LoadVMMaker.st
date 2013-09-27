NonInteractiveTranscript stdout install.

Gofer new
      url: 'http://ss3.gemstone.com/ss/FileTree';
      package: 'ConfigurationOfFileTree';
      load.
(Smalltalk at: #ConfigurationOfFileTree) load.

Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfCog';
	load.	
(Smalltalk at: #ConfigurationOfCog) loadGit.

ThreadSafeTranscript install.

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].