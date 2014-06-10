translation support
numElementsIn: anArray
	<cmacro: '(anArray) (sizeof(anArray)/sizeof(anArray[0]))'>
	^anArray size