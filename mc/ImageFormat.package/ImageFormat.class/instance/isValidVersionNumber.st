private
isValidVersionNumber
	"True if the version number uses a known base version number and does not
	use any reserved bits. Used only for unit tests, by definition this must always
	be true."

	^(BaseVersionNumbers includes: self baseVersionBits)
		and: [(self asInteger bitAnd: ReservedBitsMask) = 0]