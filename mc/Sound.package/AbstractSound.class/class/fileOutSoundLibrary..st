sound library-file in/out
fileOutSoundLibrary: aDictionary
	"File out the given dictionary, which is assumed to contain sound and instrument objects keyed by their names."
	"Note: This method is separated out so that one can file out edited sound libraries, as well as the system sound library. To make such a collection, you can inspect AbstractSound sounds and remove the items you don't want. Then do: 'AbstractSound fileOutSoundLibrary: self' from the Dictionary inspector."

	| fileName refStream |
	(aDictionary isKindOf: Dictionary)
		ifFalse: [self error: 'arg should be a dictionary of sounds'].
	fileName := UIManager default request: 'Sound library file name?'.
	fileName isEmptyOrNil ifTrue: [^ self].
	refStream := SmartRefStream fileNamed: fileName, '.sounds'.
	[ refStream nextPut: aDictionary ]
		ensure: [ refStream close ]