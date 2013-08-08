other
readSampleSetFrom: dirName
	"Answer a collection of sounds read from AIFF files in the given directory and sorted in ascending pitch order."

	| all dir |
	all := SortedCollection sortBlock: [:s1 :s2 | s1 pitch < s2 pitch].
	dir := FileSystem workingDirectory on: dirName.
	dir fileNames do: [:n | | fullName snd |
		fullName := (dir asFileReference / n) fullName.
		UIManager default
			informUser: 'Reading AIFF file ', n
			during:
				[snd := LoopedSampledSound new
					fromAIFFFileNamed: fullName
					mergeIfStereo: true].
		all add: snd].
	^ all asArray
