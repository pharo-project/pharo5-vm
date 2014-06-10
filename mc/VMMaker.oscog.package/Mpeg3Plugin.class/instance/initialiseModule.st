support
initialiseModule
	<export: true>
	maximumNumberOfFilesToWatch := 1024.
	1 to: maximumNumberOfFilesToWatch do: [:i | mpegFiles at: i put: 0].
	^self cCode: 'true' inSmalltalk:[true]