# Re-emvoweler

Merge a list of consonants and a list of vowels into a list of words.

[![Build Status](https://travis-ci.org/petertseng-dp/reemvoweler.svg?branch=master)](https://travis-ci.org/petertseng-dp/reemvoweler)

# Notes

The basic algorithm isn't hard to conceptualize.
Keep track of letters in the candidate word, and at any point either try to extend it with a letter from any list or make it a complete word.

This even applies to arbitrary numbers of lists of arbitrary letters.

If there is only one letter list, this becomes the problem of "insert spaces in this letter list to make it a word list", an [old interview question](http://thenoisychannel.com/2011/08/08/retiring-a-great-interview-problem).
If there is only one letter per list, this becomes an anagram finder.

The exhaustive search takes a bit too long for the inputs from the source page.
A more pared-down word list would reduce the time taken, of course, but I lack the time to minimize.
In addition, I am probably making inefficient allocations.
However, I'm not really motivated to do better.

Takes 25 seconds to run llfyrbsshvtsmpntbncnfrmdbyncdt aoouiaeaeaoeoieeoieaeoe.
Takes about 225 seconds to run bbsrshpdlkftbllsndhvmrbndblbnsthndlts aieaeaeieooaaaeoeeaeoeaau.

# Source

https://www.reddit.com/r/dailyprogrammer/comments/1yzlde
