package properties
archiveMD5Sum
	"answer the MD5 checksum (in string) for downloaded library archive 
	(to check that downloaded file is not corrupt).
	
	You can take this sum by issuing:
	  md5 filename
	from command line
	"
	^ self subclassResponsibility