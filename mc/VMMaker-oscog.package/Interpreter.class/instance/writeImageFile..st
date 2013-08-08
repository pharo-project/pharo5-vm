image save/restore
writeImageFile: imageBytes

	| fn |
	<var: #fn type: 'void *'>
	self writeImageFileIO: imageBytes.
	"set Mac file type and creator; this is a noop on other platforms"
	fn := self ioLoadFunction: 'setMacFileTypeAndCreator' From: 'FilePlugin'.
	fn = 0 ifFalse:[
		self cCode:'((sqInt (*)(char*, char*, char*))fn)(imageName, "STim", "FAST")'.
	].
