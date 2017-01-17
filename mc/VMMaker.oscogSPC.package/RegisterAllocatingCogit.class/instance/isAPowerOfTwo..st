bytecode generator support
isAPowerOfTwo: anInteger 
	<inline: true>
	^(anInteger bitAnd: anInteger - 1) = 0