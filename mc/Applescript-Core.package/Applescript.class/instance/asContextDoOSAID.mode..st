interpreting
asContextDoOSAID: scptOSAID mode: anInteger
	"Answer a string corresponding to the result of executing preloaded scptOSAID using my compiledScript as the context, and using mode anInteger.  As a side-effect, update my script information as necessary.  (This routine will not update any stored versions of scptOSAID"

	^self 
		doAsOSAID: 
			[:contextOSAID |
			 ApplescriptGeneric 
				executeAndDisplayOSAID: scptOSAID
				in: contextOSAID
				mode: anInteger]
		onErrorDo: 		
			[ApplescriptError 
				syntaxErrorFor: (ByteString streamContents:
					[:aStream |
					 aStream 
						nextPutAll: (ApplescriptGeneric sourceOfOSAID: scptOSAID); cr; cr;
						nextPutAll: '<=== Source Code of Context ===>'; cr;
						nextPutAll: source])
				withComponent: ApplescriptGeneric]