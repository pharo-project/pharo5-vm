interpreter access
classTagForSpecialObjectsIndex: splObjIndex compactClassIndex: compactClassIndex
	"For compatibility with Spur.  Answer the class tag to use to lookup a method in the
	 first-level method lookup cache."
	^self splObj: splObjIndex