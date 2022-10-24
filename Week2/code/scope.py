#!/usr/bin/env python3

"""A scirpt containing a function that determine a variable within a scope."""

__author__ = 'Pasith Prayoonrat (pp1922@ic.ac.uk)'
__version__ = '0.0.1'

# example of local variables (= only accessible inside their function)
i = 1
x = 0
for i in range(10):
    x += 1
print(x)
print(i)


# now encapsulating this loop into a function...
i = 1
x = 0
def a_function(y):
    """Add one to variable 'x' 'y' times and return x"""
    x = 0
    for i in range(y):
        x += 1
    return x
x = a_function(10)
print(x)
print(i)
## --> both x and i are localised to the function
## --> x was updated to the main workspace bc it was explicitly returned from the function
## --> i remained unchanged outside the function bc it was not returned


####################################################################################

# GLOBAL VARIABLES

# example:

_a_global = 10 # a global variable

if _a_global >= 5:
    _b_global = _a_global + 5 # also a global variable
    
print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_function():
    """Define a local variable. If it is greater than or equal to four, add five and assign to a new local variable. Also define another local variable."""
    _a_global = 4 # a local variable
    
    if _a_global >= 4:
        _b_global = _a_global + 5 # also a local variable
    
    _a_local = 3
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)

#print("After calling a_function, outside the function, the value of _a_local is ", _a_local)
# this line returns an error because _a_local was only defined as a local variable inside the function a_function so does not exist globally

## --> what happens in the function stays in the function (i.e. overwriting _a_global)
## --> _a_local doesn't persist outside the function (hence the NameError at the end)


# if you assign a variable outside the function it'll still be available inside the function even if you don't assign it inside that function:

_a_global = 10

def a_function():
    """Define a local variable and print its value as well as that of a previously-defined global variable"""
    _a_local = 4
    
    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)
    
a_function()

print("Outside the function, the value of _a_global is", _a_global)


# to modify/assign a global variable from inside a function, you can use the global keyword:

_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    """Use the 'global' keyword to modify global variable _a_global and assign a new variable _a_local, then print their values"""
    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global now is", _a_global)


# the global keyword also works from inside nested functions:

def a_function():
    """Define the variable _a_global as 10 and define a nested function '_a_function2' which modifies its value using the 'global' keyword, then print the values of _a_global before and after applying the nested function"""
    _a_global = 10

    def _a_function2():
        """Re-assign the value of the variable _a_global to 20 using the 'global' keyword"""
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)
    
a_function()

print("The value of a_global in main workspace / namespace now is", _a_global)

## --> i.e. using a global keyword inside the inner function _a_function2 resulted in changing the value of _a_global in the main workspace to 20, but within the scope of the _a_function its value remained 10


# compare with this:

_a_global = 10

def a_function():
    """Define a nested function '_a_function2' which reassigns the vale of a variable _a_global to 20. Print the original value of _a_global, then apply the function _a_function2 to it, then print its value after applying this function"""

    def _a_function2():
        """Reassign the value of _a_global as 20"""
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)

## --> bc _a_global was defined in advance, when _a_function was run:
## - this value was inherited within _a_function from the main workspace
## - it was then given a global designation in the inner function _a_function2
## - then in the inner function _a_function2 when it was changed to a different value it was modified everywhere
