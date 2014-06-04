accessing
stampInsertString: commentToInsert
	"If set, the commentToInsert will be used for method stamp modification
	rather than the default conversion value. This is intended to permit a
	Pragmatizer to reproduce a previous conversion, e.g. the previously converted
	methods in the Cog VM."

	stampInsertString := commentToInsert
