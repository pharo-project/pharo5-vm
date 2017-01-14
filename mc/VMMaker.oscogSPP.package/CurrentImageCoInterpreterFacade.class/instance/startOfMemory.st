accessing
startOfMemory
	"Use the top half of memory for variables, methodcache and rumpCStack,
	 and the bottom half for allocating code and objects:

		0 - 256k:			code zone
		256k to 512k		object zone
		512k to 768k		variables
		768k to 1023k		method cache
		 1023k to 1024k	rump C stack"
	^memory byteSize / 4