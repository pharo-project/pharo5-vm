printing
printOn: aStream level: level

	aStream crtab: level.
	aStream nextPutAll: 'switch ('.
	expression printOn: aStream level: level.
	aStream nextPutAll: ') {'.
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 aStream
				crtab: level;
				nextPutAll: 'case '.
			label printOn: aStream level: level + 1.
			aStream nextPut: $:].
		  aStream crtab: level + 1.
		  case printOn: aStream level: level + 1.
		  aStream crtab: level + 1; nextPutAll: 'break;']
			valueWithArguments: tuple].
	otherwiseOrNil ifNotNil:
		[aStream
			crtab: level;
			nextPutAll: 'default:';
			crtab: level + 1.
		 otherwiseOrNil printOn: aStream level: level + 1].
	aStream
		crtab: level;
		nextPut: $}