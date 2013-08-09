private - handle conversion
stdOutputHandle
	"Answer the pseudo HANDLE for standard output."

	<returnTypeC: 'HANDLE'>
	^ self cCode: '(HANDLE) STD_OUTPUT_HANDLE' inSmalltalk: ['16rFFFFFFF5' asNumber]
