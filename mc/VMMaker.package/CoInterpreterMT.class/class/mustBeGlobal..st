translation
mustBeGlobal: var
	"Make disownCount global so that debugging/instrumentation code can use it to check
	 if a threaded FFI call is in progress (i.e. this isn't necessary for production)"

	^(super mustBeGlobal: var)
	   or: [ #('disownCount' 'willNotThreadWarnCount') includes: var]