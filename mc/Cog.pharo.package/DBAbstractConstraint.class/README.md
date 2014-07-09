I am an abstract class representing a system-maintainable relationship (or "constraint") between a set of variables. I supply a strength instance variable; concrete subclasses provide a means of storing the constrained variables and other information required to represent a constraint.

Instance variables:
	strength			the strength of this constraint <Strength>