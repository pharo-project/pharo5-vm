A SMarkTimer is a simple timer.
A subclass can measure alternative metrics, or for instance use different time sources.

A subclass of SMarkRunner can then use the custom timer class by overriding SMarkRunner class >> #defaultTimer.