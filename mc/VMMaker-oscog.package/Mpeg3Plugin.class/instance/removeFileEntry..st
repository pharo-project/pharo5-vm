support
removeFileEntry: aMpegFile
	<var: #aMpegFile type: 'mpeg3_t * '>
	1 to: maximumNumberOfFilesToWatch do: 
		[:i | ((mpegFiles at: i) = aMpegFile) ifTrue: 
				[mpegFiles at: i put: 0.
				^true]].
	"Just ignore"
	^false
		
	