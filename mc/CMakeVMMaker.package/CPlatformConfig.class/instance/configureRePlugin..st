plugin extra rules
configureRePlugin: maker 
	"extra rules for RePlugin"

	maker addCrossSources: #(
		'pcre.c' 'study.c' 'get.c' 'chartables.c').
