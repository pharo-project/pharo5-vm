cog jit support
methodCacheAddress
	<api>
	<returnTypeC: #'void *'>
	^self cCode: [methodCache] inSmalltalk: [methodCache address]