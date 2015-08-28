# rulecoder
This program is basically a simplified version of something I wrote in Python about 12-18 months ago for my job. It reads in a set of expenditure data from a school district, reads in a set of rules defined by the user, and applies the rules to the district data, returning a new file with the rules applied.

This ultimately led us down a slightly different path: a data science competition to create a ML algorithm to do the job rather than human-generated rules. You can read more about that here: www.drivendata.org/competitions/4/.

The original program had some more advanced features - it could also search using regexes, and I started to play around with a points system so certain rules could be weighted more heavily than others. But for our purposes, I'm hoping this suffices.

I've included the kind of data and rules you might see here as examples. In reality, the district data would be tens of thousands of rows, and there would be hundreds of rules.
