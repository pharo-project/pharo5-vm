accessing
maxCogCodeSize
	"We restrict the maximum size of the code zone to 16Mb to allow inter-method
	 calls and jumps to use small offset call and jump instructions if appropriate."
	<api>
	<cmacro: '() (16*1024*1024)'>
	^16*1024*1024