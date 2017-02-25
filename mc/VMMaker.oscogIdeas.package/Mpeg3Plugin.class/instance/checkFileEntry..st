support
checkFileEntry: aMpegFile
	<var: #aMpegFile type: 'mpeg3_t * '>
	1 to: maximumNumberOfFilesToWatch do: 
		[:i | ((mpegFiles at: i) = aMpegFile) ifTrue: 
				[^true]].
	^false.
		
	