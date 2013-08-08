Gofer new 
	squeaksource3: 'PharoInbox';
	package: 'SLICE-Issue-11209-backport-20-Add-RPackageSet-cache';
	merge.

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

(Smalltalk saveAs: 'generator') 
    ifFalse: [ Smalltalk snapshot: false andQuit: true ].