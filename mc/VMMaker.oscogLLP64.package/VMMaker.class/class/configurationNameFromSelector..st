confs-support
configurationNameFromSelector: aSelector
	^(aSelector piecesCutWhere: [:a :b| a isLowercase and: [b isUppercase]]) allButFirst fold: [:a :b| a, ' ', b]