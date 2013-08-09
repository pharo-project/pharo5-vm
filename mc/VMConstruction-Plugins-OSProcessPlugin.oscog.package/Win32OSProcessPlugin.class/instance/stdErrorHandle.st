private - handle conversion
stdErrorHandle
	"Answer the pseudo HANDLE for standard error."

	<returnTypeC: 'HANDLE'>
	^ self cCode: '(HANDLE) STD_ERROR_HANDLE' inSmalltalk: ['16rFFFFFFF4' asNumber]
