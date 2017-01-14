support
makeFileEntry: aMpegFile
	<var: #aMpegFile type: 'mpeg3_t * '>
	1 to: maximumNumberOfFilesToWatch do: 
		[:i | ((mpegFiles at: i) = 0) ifTrue: 
				[mpegFiles at: i put: aMpegFile.
				^true]].
	^false
	"Ok no room just ignore, we'll get a primitive failure later"
		
	