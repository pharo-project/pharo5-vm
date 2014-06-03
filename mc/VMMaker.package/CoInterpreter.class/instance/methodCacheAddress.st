cog jit support
methodCacheAddress
	<api>
	<returnTypeC: #'void *'>
	^self cCode: 'GIV(methodCache)' inSmalltalk: [methodCache offset * BytesPerWord]