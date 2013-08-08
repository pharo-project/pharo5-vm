settings
precompiledHeaders 
	^
'//
// Prefix header for all source files of the ''', self executableName, ''' target in the ''', self executableName, ''' project
//

#ifdef __OBJC__
	', 
	(String streamContents: [ :stream | 
		self precompiledImports 
			do: [ :each | 
				stream 
					nextPutAll: '#import ';
					nextPut: $<;
					nextPutAll: each; 
					nextPut: $> ]
			separatedBy: [ 
				stream cr ] ]),  '
#endif
'