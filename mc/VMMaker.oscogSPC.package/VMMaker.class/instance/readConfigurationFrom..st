objects from disk
readConfigurationFrom: aFileName
	"read info about the current configuration from a file. Return the array that would have been made by #configurationInfo"
	|  fileStream |

	fileStream := FileStream oldFileNamed: aFileName.
	^fileStream fileInObjectAndCode