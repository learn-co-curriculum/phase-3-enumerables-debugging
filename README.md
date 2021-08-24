# Enumerables: Debugging with Pry

## Learning Goals

- Use Pry to debug code running in enumerable method blocks

## Introduction

Methods using enumerables and loops can be a bit more challenging to debug than
other methods. In this lesson, you'll practice using `binding.pry` to pause the
execution of your code inside a loop so you can inspect variables in enumerable
methods.

## Code Along

Fork and clone this lesson to code along!

In this lesson, we'll be writing a method called `#reverse_each_word` that takes
in a argument of a sentence as a string, and returns that same sentence with
each word reversed in place.

The input will be a sentence, like this:

```rb
"Hello there, and how are you?"
```

And calling our method will produce an output like this:

```rb
reverse_each_word("Hello there, and how are you?")
  #=> "olleH ,ereht dna woh era ?uoy"
```

Before writing this method out, let's do a bit of pseudocoding, and decide how
we need to approach this problem:

- Split the string on " " to get access to each word in the sentence
- Reverse each word, and add it to a new array
- Join the array of words on " " to create one string

With that plan of attack in mind, let's start writing the method, and use
`pry` to check our work on each step of this pseudocode.

### Step 1: Splitting the String

To start, add the following code to your `reverse_each_word.rb` file:

```rb
require 'pry'

def reverse_each_word(sentence)
  binding.pry
end

reverse_each_word("Hello there, and how are you?")
```

Then run the file with `ruby reverse_each_word.rb`. From the Pry session in your
terminal, inspect the `sentence` variable:

```rb
sentence
# => "Hello there, and how are you?"
```

Now, let's try getting the first step of our pseudocode working from the
Pry session:

> Split the string on " " to get access to each word in the sentence

We can use the `#split` method for this:

```rb
sentence.split(" ")
# => ["Hello", "there,", "and", "how", "are", "you?"]
```

We can also use `#split` with no arguments, since the default argument is a
space:

```rb
sentence.split
# => ["Hello", "there,", "and", "how", "are", "you?"]
```

Great! Now that we know this method works in Pry, exit out of Pry in the
terminal by typing `exit` or `control + d`. Then, back in the
`reverse_each_word.rb` file, add this code to the method:

```rb
def reverse_each_word(sentence)
  words = sentence.split
end
```

### Step 2: Reverse Each Word

For the next step of our pseudocode, we'll need to tackle this problem:

> Reverse each word, and add it to a new array

We can break this step down a bit further:

- Create a new array
- Iterate over the array of words
- Reverse each word, and add it to the new array

Let's start by creating a variable for the new array:

```rb
def reverse_each_word(sentence)
  words = sentence.split
  reversed_words = []
end
```

Then, we'll need iterate over each word in the array and reverse it. You might
know what do to from here, but to get some practice with Pry, let's add a
`binding.pry` breakpoint inside the `#each` loop:

```rb
def reverse_each_word(sentence)
  words = sentence.split
  reversed_words = []

  words.each do |word|
    binding.pry
  end
end
```

Run the program again with `ruby reverse_each_word.rb`. You'll now enter a Pry
session within the `#each` loop! This makes it easy to see what's happening as
you iterate over the array.

**NOTE**: Depending on the size of your terminal window, Pry might not be able
to fit your entire method on the screen, in which case you'll see a screen like this:

```txt
     5: def reverse_each_word(sentence)
     6:   words = sentence.split
     7:   reversed_words = []
     8:
     9:   words.each do |word|
    10:     binding.pry
    11:   end
:
```

If you ever get into this situation, just type the letter `q` in the terminal to
exit out.

From here, our goal from the pseudocode is to:

> Reverse each word, and add it to the new array

We can try this out in the Pry session:

```rb
word
# => "Hello"
word.reverse
# => "olleH"
reversed_words << word.reverse
# => ["olleH"]
```

Success! Type `exit` now. This will exit the current breakpoint, but since our
code is running in a loop, we'll hit the same breakpoint again, with the next
word in the array:

```rb
word
# => "there,"
reversed_words << word.reverse
# => ["olleH", ",ereht"]
```

You can type `exit` again to see the next word, but if you're confident your
code is working as expected, you can exit from Pry entirely by typing
`exit-program` or `!!!`.

> You can also see a list of all Pry commands by typing `help` from your Pry
> session.

Add the working code to your method. All together, your files should look like
this:

```rb
require 'pry'

def reverse_each_word(sentence)
  words = sentence.split
  reversed_words = []

  words.each do |word|
    reversed_words << word.reverse
  end
end

reverse_each_word("Hello there, and how are you?")
```

### Step 3: Join the Reversed Array

We're onto the last step of our pseudocode:

> Join the array of words on " " to create one string

Let's use Pry one more time to check our work:

```rb
def reverse_each_word(sentence)
  words = sentence.split
  reversed_words = []

  words.each do |word|
    reversed_words << word.reverse
  end

  binding.pry
end
```

Run the program again. From the Pry session, we can use the `#join` method to
create a string from our array of reversed words.

> Remember: hit the `q` key if you're unable to interact with the terminal in
> Pry!

```rb
reversed_words.join
# => "olleH,erehtdnawohera?uoy"
reversed_words.join(" ")
# => "olleH ,ereht dna woh era ?uoy"
```

We've done it! Exit the Pry session, and add that final bit of code in:

```rb
require 'pry'

def reverse_each_word(sentence)
  words = sentence.split
  reversed_words = []

  words.each do |word|
    reversed_words << word.reverse
  end

  reversed_words.join(" ")
end

reverse_each_word("Hello there, and how are you?")
```

Now, let's test out our method by running the file once more with
`ruby reverse_each_word.rb`:

```console
$ ruby reverse_each_word.rb
...
```

Hmmm... There's no output, and there are no tests to run! How can we tell if the
program is doing what we expect? One way would be to use `puts` to inspect the
output of running the method:

```rb
require 'pry'

def reverse_each_word(sentence)
  words = sentence.split
  reversed_words = []

  words.each do |word|
    reversed_words << word.reverse
  end

  reversed_words.join(" ")
end

puts reverse_each_word("Hello there, and how are you?")
```

Now that we've got some terminal output, we can see if the method does indeed
produce the desired return value:

```console
$ ruby reverse_each_word.rb
olleH ,ereht dna woh era ?uoy
```

Pry is also useful in this situation. Add a `binding.pry` at the bottom of the
file, followed by a 0:

```rb
require 'pry'

def reverse_each_word(sentence)
  words = sentence.split
  reversed_words = []

  words.each do |word|
    reversed_words << word.reverse
  end

  reversed_words.join(" ")
end

binding.pry
0
```

> The 0 is necessary because of some [quirky behavior][pry bug] with
> `binding.pry`: you can't use a breakpoint as the last line of code in a
> program. So adding any arbitrary data on the line below ensures our breakpoint
> will be hit.

[pry bug]: https://github.com/deivid-rodriguez/pry-byebug/issues/45

Then run `ruby reverse_each_word.rb` again to run the program, and enter a Pry
session. From this Pry session, you can test your method with any data you like:

```rb
reverse_each_word("does it work?")
# => "seod ti ?krow"
reverse_each_word("i think it does")
# => "i kniht ti seod"
reverse_each_word("racecar madam wow")
# => "racecar madam wow"
```

### Bonus: Refactor

If you've had enough, feel free to skip ahead to the conclusion; for those
interested in refactoring our `reverse_each_word` method, stick around!

Take a moment to review the code from the final version of our method:

```rb
def reverse_each_word(sentence)
  words = sentence.split
  reversed_words = []

  words.each do |word|
    reversed_words << word.reverse
  end

  reversed_words.join(" ")
end
```

It works as intended, but are there any ways we could make this code a bit
cleaner? In particular, think about our use of the `#each` method: are there any
other methods that might be better suited for the task at hand? We're trying to
iterate over every element of an array, transform it in some way, and return a new array.

Sounds like the perfect job for `#map`! Try updating the method using the code
below, and run `ruby reverse_each_word.rb` to check that the refactor still
produces the expected result.

```rb
def reverse_each_word(sentence)
  words = sentence.split

  reversed_words = words.map do |word|
    word.reverse
  end

  reversed_words.join(" ")
end
```

We could also write out `#map` using the [Proc shorthand][proc shorthand]
syntax:

```rb
def reverse_each_word(sentence)
  words = sentence.split

  reversed_words = words.map(&:reverse)

  reversed_words.join(" ")
end
```

[proc shorthand]: https://www.honeybadger.io/blog/how-ruby-ampersand-colon-works/

We can also take advantage of some method chaining to combine all this on one
line:

```rb
def reverse_each_word(sentence)
  sentence.split.map(&:reverse).join(" ")
end
```

## Conclusion

You've now had a chance to use Pry for breakpoint debugging in a few scenarios.
This kind of debugging is a great way to gain confidence in what your code is
doing, so make sure to practice using `binding.pry` in the lessons to come!

## Resources

- [Pry wiki](https://github.com/pry/pry/wiki)
