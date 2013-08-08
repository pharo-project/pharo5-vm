as yet unclassified
crossSources
	"answer the same set of source files except that sqTicker.c is dropped"

  ^ super crossSources select: [ :file | (file = 'sqTicker.c') not ].

