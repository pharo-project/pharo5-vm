public
addHeaderFileFirst: aString
	"Add a header file to the front of the sequence."
	self assert: (('"<' includes: aString first) and: ['">' includes: aString last]).
	self assert: (headerFiles includes: aString) not.
	headerFiles addFirst: aString