support
shutdownModule
	<export: true>
	1 to: maximumNumberOfFilesToWatch do: 
		[:i | ((mpegFiles at: i) ~= 0) ifTrue:
			[self cCode: 'mpeg3_close(mpegFiles[i])'.
			mpegFiles at: i put: 0]].
	^self cCode:  'true' inSmalltalk:[true]