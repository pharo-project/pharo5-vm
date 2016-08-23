initialize
initialiseModule
	^(actualPlugin respondsTo: #initialiseModule) not
	  or: [actualPlugin initialiseModule]