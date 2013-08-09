private - handle conversion
stdInputHandle
	"Answer the pseudo HANDLE for standard input."

	<returnTypeC: 'HANDLE'>
	^ self cCode: '(HANDLE) STD_INPUT_HANDLE' inSmalltalk: ['16rFFFFFFF6' asNumber]
