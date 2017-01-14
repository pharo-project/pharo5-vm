simulation
sqResolverStartName: aCArray Lookup: size
	"For now don't simulate the implicit semaphore."
	| hostName busy |
	busy := NetNameResolver classPool at: #ResolverBusy.
	hostName := self st: (String new: size) rn: aCArray cpy: size.
	NetNameResolver primStartLookupOfName: hostName.
	resolverSemaphoreIndex ifNotNil:
		[[[NetNameResolver primNameResolverStatus = busy] whileTrue:
			[(Delay forSeconds: 1) wait].
		 interpreterProxy signalSemaphoreWithIndex: resolverSemaphoreIndex] fork]
	 