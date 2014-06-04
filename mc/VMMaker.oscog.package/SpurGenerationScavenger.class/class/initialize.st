class initialization
initialize
	"SpurGenerationScavenger initialize"
	RememberedSetLimit := 64 * 1024. "temporary; must move to heap"
	RememberedSetRedZone := RememberedSetLimit - (RememberedSetLimit // 2).

	TenureByAge := 1.
	TenureByClass := 2.
	DontTenure := 3.
	DontTenureButDoUnmark := 4.
	MarkOnTenure := 5