planning
chooseMethod: mark
	"Decide if I can be satisfied and record that decision."

	satisfied :=
		output mark ~= mark and:
		[strength stronger: output walkStrength].