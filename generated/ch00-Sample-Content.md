# Sample Content


## 1.4 Finding the Largest or Smallest N Items

### Problem

You want to make a list of the largest or smallest N items in a
collection.

### Solution

The `heapq` module has two functions&#8212;<literal>nlargest()</literal> and <literal>nsmallest()</literal>&#x2014;that do exactly what you want.  For example:



``` python
import heapq

nums = [1, 8, 2, 23, 7, -4, 18, 23, 42, 37, 2]
print(heapq.nlargest(3, nums))  # Prints [42, 37, 23]
print(heapq.nsmallest(3, nums)) # Prints [-4, 1, 2]

```


Both functions also accept a key parameter that allows them to be used
with more complicated data structures.  For example:



``` python
portfolio = [
   {'name': 'IBM', 'shares': 100, 'price': 91.1},
   {'name': 'AAPL', 'shares': 50, 'price': 543.22},
   {'name': 'FB', 'shares': 200, 'price': 21.09},
   {'name': 'HPQ', 'shares': 35, 'price': 31.75},
   {'name': 'YHOO', 'shares': 45, 'price': 16.35},
   {'name': 'ACME', 'shares': 75, 'price': 115.65}
]

cheap = heapq.nsmallest(3, portfolio, key=lambda s: s['price'])
expensive = heapq.nlargest(3, portfolio, key=lambda s: s['price'])
cheap
```



``` python
expensive
```


### Discussion

If you are looking for the N smallest or largest items and N is
small compared to the overall size of the collection, these functions
provide superior performance.   Underneath the covers, they work by
first converting the data into a list where items are ordered as a heap.
For example:



``` python
nums = [1, 8, 2, 23, 7, -4, 18, 23, 42, 37, 2]
import heapq
heap = list(nums)
heapq.heapify(heap)
heap    

```


The most important feature of a heap is that `heap[0]` is always the
smallest item.  Moreover, subsequent items can be easily found using
the `heapq.heappop()` method, which pops off the first item and
replaces it with the next smallest item (an operation that requires
O(log N) operations where N is the size of the heap).  For example, to
find the three smallest items, you would do this:



``` python
heapq.heappop(heap)    

```



``` python
heapq.heappop(heap)    

```



``` python
heapq.heappop(heap)    

```


The `nlargest()` and `nsmallest()` functions are most
appropriate if you are trying to find a relatively small number of
items.  If you are simply trying to find the single smallest or
largest item (N=1), it is faster to use `min()` and `max()`.
Similarly, if N is about the same size as the collection itself, it is
usually faster to sort it first and take a slice (i.e., use
`sorted(items)[:N]` or `sorted(items)[-N:]`). It should be noted that
the actual implementation of `nlargest()` and `nsmallest()` is
adaptive in how it operates and will carry out some of these
optimizations on your behalf (e.g., using sorting if N is close to the
same size as the input).

Although it's not necessary to use this recipe, the implementation of
a heap is an interesting and worthwhile subject of study.  This can
usually be found in any decent book on algorithms and data structures.
The documentation for the `heapq` module also discusses the underlying
implementation details.



## 1.3 Keeping the Last N Items

### Problem

You want to keep a limited history of the last few items seen
during iteration or during some other kind of processing.

### Solution

Keeping a limited history is a perfect use for a `collections.deque`.
For example, the following code performs a simple text match on a
sequence of lines and yields the matching line along with the previous
N lines of context when found:



``` python
from collections import deque

def search(lines, pattern, history=5):
    previous_lines = deque(maxlen=history)
    for line in lines:
        if pattern in line:
            yield line, previous_lines
        previous_lines.append(line)

# Example use on a a list of lines
lines = [
   'line1',
   'line2',
   'line3',
   'line4',
   'line5',
   'line6',
   'python',
]

for line, prevlines in search(lines, 'python', 3):
    for pline in prevlines:
        print(pline)
    print(line)
    print('-'*20)

```


### Discussion

When writing code to search for items, it is common to use a generator
function involving `yield`, as shown in this recipe's solution.  This decouples the process
of searching from the code that uses the results.   If you're new
to generators, see <a href="#generators">[generators]</a>.

Using `deque(maxlen=N)` creates a fixed-sized queue.  When new items
are added and the queue is full, the oldest item is automatically
removed.   For example:



``` python
q = deque(maxlen=3)
q.append(1)
q.append(2)
q.append(3)
q    

```



``` python
q.append(4)
q    

```



``` python
q.append(5)
q    

```


Although you could manually perform such operations on a list (e.g.,
appending, deleting, etc.), the queue solution is far more elegant and
runs a lot faster.

More generally, a `deque` can be used whenever you need a simple queue
structure.  If you don't give it a maximum size, you get an unbounded
queue that lets you append and pop items on either end.  For example:



``` python
q = deque()
q.append(1)
q.append(2)
q.append(3)
q    

```



``` python
q.appendleft(4)
q    

```



``` python
q.pop()    

```



``` python
q    

```



``` python
q.popleft()    

```


Adding or popping items from either end of a queue has O(1)
complexity.   This is unlike a list where inserting or removing
items from the front of the list is O(N).



## 1.2 Unpacking Elements from Iterables of Arbitrary Length

### Problem

You need to unpack N elements from an iterable, but the iterable may be
longer than N elements, causing a "too many values to unpack" exception.

### Solution

Python "star expressions" can be used to address this
problem. For example, suppose you run a course and decide at the end
of the semester that you're going to drop the first and last homework
grades, and only average the rest of them. If there are only four
assignments, maybe you simply unpack all four, but what if there are 24?
A star expression makes it easy:



``` python
def drop_first_last(grades):
    first, *middle, last = grades
    return sum(middle)/len(middle)

grades = [2.0, 3.0, 4.0, 9.0]
drop_first_last(grades)
```


As another use case, suppose you have user records that consist of a name and
email address, followed by an arbitrary number of phone numbers. You could
unpack the records like this:



``` python
record = ('Dave', 'dave@example.com', '773-555-1212', '847-555-1212')
name, email, *phone_numbers = record
name    

```



``` python
email    

```



``` python
phone_numbers    

```


It's worth noting that the `phone_numbers` variable will always be a
list, regardless of how many phone numbers are unpacked (including
none).  Thus, any code that uses `phone_numbers` won't have to account
for the possibility that it might not be a list or perform any kind of
additional type checking.

The starred variable can also be the first one in the list. For example, say
you have a sequence of values representing your company's sales figures for the last eight
quarters. If you want to see how the most recent quarter stacks up to
the average of the first seven, you could do something like this:


```
*trailing_qtrs, current_qtr = sales_record
trailing_avg = sum(trailing_qtrs) / len(trailing_qtrs)
return avg_comparison(trailing_avg, current_qtr)
```

Here's a view of the operation from the Python interpreter:



``` python
*trailing, current = [10, 8, 7, 1, 9, 5, 10, 3]
trailing    

```



``` python
current    

```


### Discussion

Extended iterable unpacking is tailor-made for unpacking iterables of
unknown or arbitrary length. Oftentimes, these iterables have some
known component or pattern in their construction (e.g. "everything after element 1 is a phone number"), and star
unpacking lets the developer leverage those patterns easily instead of
performing acrobatics to get at the relevant elements in the iterable.

It is worth noting that the star syntax can be especially useful when
iterating over a sequence of tuples of varying length.  For example,
perhaps a sequence of tagged tuples:



``` python
records = [
     ('foo', 1, 2),
     ('bar', 'hello'),
     ('foo', 3, 4),
]

def do_foo(x, y):
    print('foo', x, y)

def do_bar(s):
    print('bar', s)

for tag, *args in records:
    if tag == 'foo':
        do_foo(*args)
    elif tag == 'bar':
        do_bar(*args)

```


Star unpacking can also be useful when combined with certain kinds
of string processing operations, such as splitting.  For example:



``` python
line = 'nobody:*:-2:-2:Unprivileged User:/var/empty:/usr/bin/false'
uname, *fields, homedir, sh = line.split(':')
uname    

```



``` python
homedir    

```



``` python
sh    

```


Sometimes you might want to unpack values and throw them away.
You can't just specify a bare `*` when unpacking, but you could
use a common throwaway variable name, such as `_` or `ign` (ignored).
For example:



``` python
record = ('ACME', 50, 123.45, (12, 18, 2012))
name, *_, (*_, year) = record
name    

```



``` python
year    

```


There is a certain similarity between star unpacking and list-processing
features of various functional languages.  For example, if you have a
list, you can easily split it into head and tail components like this:



``` python
items = [1, 10, 7, 4, 5, 9]
head, *tail = items
head    

```



``` python
tail    

```


One could imagine writing functions that perform such splitting in
order to carry out some kind of clever recursive algorithm. For example:



``` python
def sum(items):
    head, *tail = items
    return head + sum(tail) if tail else head
sum(items)    

```


However, be aware that recursion really isn't a strong Python feature due to
the inherent recursion limit.  Thus, this last example might be nothing
more than an academic curiosity in practice.



``` python

```



## 1.1 Unpacking a Sequence into Separate Variables

### Problem

You have an N-element tuple or sequence that you would like to unpack into a
collection of N variables.

### Solution

Any sequence (or iterable) can be unpacked into variables using a simple
assignment operation.  The only requirement is that the number of
variables and structure match the sequence.  For example:



``` python
p = (4, 5)
x, y = p
x    

```



``` python
y    

```



``` python
data = [ 'ACME', 50, 91.1, (2012, 12, 21) ]
name, shares, price, date = data
name    

```



``` python
date    

```



``` python
name, shares, price, (year, mon, day) = data
name    

```



``` python
year    

```



``` python
mon    

```



``` python
day    

```


If there is a mismatch in the number of elements, you'll get an error.
For example:



``` python
p = (4, 5)
x, y, z = p    

```


### Discussion

Unpacking actually works with any object that happens to be iterable,
not just tuples or lists.  This includes strings, files, iterators,
and generators. For example:



``` python
s = 'Hello'
a, b, c, d, e = s
a    

```



``` python
b    

```



``` python
e    

```


When unpacking, you may sometimes want to discard certain values.
Python has no special syntax for this, but you can often just pick a
throwaway variable name for it.  For example:



``` python
data = [ 'ACME', 50, 91.1, (2012, 12, 21) ]
_, shares, price, _ = data
shares    

```



``` python
price    

```


However, make sure that the variable name you pick isn't being
used for something else already.



``` python

```


