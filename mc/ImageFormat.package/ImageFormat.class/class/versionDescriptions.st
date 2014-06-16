utility
versionDescriptions

	"ImageFormat versionDescriptions"
	"ImageFormat versionDescriptions do: [:e | Transcript cr; show: e]"

	^ Dictionary
		withAll: (KnownVersionNumbers
				collect: [:e | e -> (self fromInteger: e) description])