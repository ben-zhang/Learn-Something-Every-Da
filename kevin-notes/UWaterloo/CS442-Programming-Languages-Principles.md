# [CS442: Programming Languages Principles](https://cs.uwaterloo.ca/~plragde/442/slides/)

### Summary
Untyped Boolean Expressions
- recursive grammar with terminals as true, false and nonterminal conditional statements
- can be simply extended to untyped arithmetic expressions, with the notion of successor/predecessor of some constant 0
- we learned that grammars formally define some syntax for a language but ultimately we must assign some semantic system to the syntax to get meaning
- operational semantics use a sort of "iterative simplification" called small-step, using an abstract machine which is essentially a state machine

Untyped Lambda Calculus
- 3 grammar production rules, other definitions follow based on the three possible 
- helps to formalize substitution, through a-equiv and B-red
  - during substitution, we have to worry about variable capture (free variable getting bound)
  - `BV[x] = empty, BV[λx.t] = BV[t] u {x}, BV[t1 t2] = BV[t1] u BV[t2]`
  - for the def of substitution, the four obvious cases, and modify to 1. not substitute for bound vars and 2. change of var to avoid variable capture
- church-rosser theorem says that normal forms are unique, but getting there can be any path in a "diamond" shape of possibilites (based on order of operations)
- standardization theorem, reducing leftmost outermost redex will find a normal form if it exists
  - NOR, normal order reduction (and is deterministic, unlike full beta reduction)

Recursion
- use some tricks to make recursion a finite substitution, we do this under normal order reduction and also under call-by-value
- we use combinators, in this case the Y combinator, to make recursion work 

Types
- we studied type inference which, instead of dynamically evaluating expressions and checking their type, looks at their parse tree before hand and infers types
- strong normalization theorem says every reduction of well-typed terms is of finite length
  - basically says in the simply typed lambda calculus system, infinite expressions aren't well typed in the first place, suggesting the system is weak
- we use type variables as placeholders for uninterpreted types
- type inference of a term is assigning appropriate variables to subterms, and trying to find a set of substitutions, sigma, that makes the term well-typed
- eventually, all variables will have a concrete type based on constraints defined in the program (like variables in an if condition must make the condition of type boolean)
- if there are still free variables in the final type for the expression, then the expression is ALMOST polymorphic
  - problem is, without changes, its first application will cause it to be specialized based on the constraints of the type we substituted in
- we introduce let-polymorphism where we can substitute a full copy of the polymorphic expression every time we use it, so that its set of type varialbles are only constrained in its specific application, and doesn't affect other applications (due to alpha renaming)

Haskell and Laziness
- laziness in haskell makes it so that it only evaluates parts of an expression that are required to return the result
- `take 1 $ quicksort` would be worst case O(n^2) since it has to complete the full algorithm in worst case because quickselect might not find the first element till the algorithm completes
- `take 1 $ mergesort` is worst case O(n) because it only needs to run a single iteration of the algorithm, grabbing the first element from each subarray and recursively grabbing the smaller of its two children

Typeclasses in Haskell
- basically like java interfaces
- Eq is a typeclass that defines the notion of equality, and we write `deriving Eq` at the end of a `data` definition to include default definitions of structural equality for a data type
- other typeclasses include Ord, Show, Functor, Applicative, Monad

[Monads](http://learnyouahaskell.com/a-fistful-of-monads)
- this is a hard topic, but monads in haskell let you program in a way that looks imperative but are actually still functional
- Monads let you chain functions together. They are types that implement `>>=` operator ("bind") which is just a fancy operator for chaining, much like a semi colon in C
- [why do we need them?](https://stackoverflow.com/questions/28139259/why-do-we-need-monads), well sometimes we want functions to be able to return more than one type and would use a type like an optional (in haskell called "Maybe"): `Just Number | Nothing`
- this is easy to implement, but we would need to REIMPLEMENT any functions that we want this to happen in
- this is fine for a single function, but for an expression that is function composition like f(g(h(x))), each of the functions needs to be reimplemented
- monads let us define how to handle breaking down and passing around values of our new type (in this case `Number | Nothing`) without needing to redefine every function in a composition expression
- it does this by defining our type as a monad, which overrides the `>>=` operator that allows us to chain functions together while handling the new optional type 

More fundamentally, we first learn about Functors and Applicatives, and Monads are just more expressive Applicative Functors which are just more expressive Functors.
- a functor is typeclass that describes types that implements fmap, which is just a generic implementation of map (lists are functors, but we can apply the same concept to optionals or other recursive structures like Trees)
- functor type constructors must always be of the form `(a -> b)` or more specifically `(a -> f a)`
- functors must obey laws about mapping
  - `fmap id (f a) = f a`, identity function should still work
  - `fmap (x . y) (f a) = fmap x $ fmap y (f a)`, composition is chaining
- Applicative is a typeclass that describes types that implement `pure` and `<*>`, which allows us to apply functions that have been wrapped in the functor, like `f (a -> b)`.
- allows us to take normal functions and wrap them in the functor using `pure`
- allows us to curry functions using `<*>`
- allows us to apply normal binary functions to two functors
- makes our lists, Maybes, functors in general more useful
- Monad is a type class that describes types that implement the interface `return` (same as `pure`), `>>=` bind operator, `>>`, and `fail`, but we mostly care about bind
- Monads enable a more expressive style of programming by allowing functions to be chained, and short circuit
- we get `do` notation as syntactic sugar for this
- this concept of "chaining" is important, because it let's us do things beyond just chaining applications together. For example, the `Maybe` monad let's us check and handle possible failure, the list monad let's us handle non-determinism by running a function on all possiblilites

### 1 Intro
Expressivity, meaning, guarantees, implementation

parantheses based syntax facilitates metaprogramming
- core language can be extended using marcos rewritten at "compile time"
- racket macro system is world class, allows hygiene to be bent through controlled manipulation of the source's abstract syntax tree

A truly minimal subset of racket: lambda abstraction & function application

#### Mutation in Racket
**mutation** is changing the value bound to a name, or stored in a data structure (think variable)
- used sparingly in scheme and racket
- why not mutation? **referential transparaency**, expressions may be replaced with one of equal value
- mutation is occasionally useful for expressivity or efficiency, but **complicates the substitution model**
- `box` provides an intermediate mutation mechanism, and is a racket value that contains a racket value

#### [More notes on Racket](https://cs.uwaterloo.ca/~plragde/tyr/)
- lambdas/closures refer to any variable in lexical scope
- lists are immutable
- has separate mutable list type
- module system is sophisticated becausae it must deal with **multi-phase macro expansion**

### 2 Logic Review & Arithmetic
Propositions are variables, with logical connectives

`Γ |- α` means “From the set of propositions Γ, we can prove the proposition α. Inference rules have their syntax, see notes.

#### Untyped Boolean Expressions
Can be described with production rules as a grammar, with term simplifying to true, false, or conditionals
- terms are really trees, that expand to the AST

Prove a property P by structural induction on the parse tree

Need meaning to our language:
- Denotational semantics: associate terms with math objects
- Axiomatic semantics: ?
- Operational semantics: evaluation of boolean expression is defined by computation of an abstract machine
  - transition function says how to reduce a term, and its machine code is a term
  - we can say that a term's meaning is the final state that the machine reaches when started with t as its initial state (small-step style of operational semantics)
- if elimination is deterministic; the relation is actually a partial function (some x have at most 1 value)
  - `if t -> t' and t -> t", then t' = t"`
- term t is in **normal form** if there is no `t' s.t. t -> t'` (only `true` and `false` in our system)
- and `if t is in normal form, then t is a value`
- `forall terms t, there is a normal form t' s.t. t ->* t'`

#### Untyped Arithmetic Expressions
In our definition of this, a number is either 0 or a successor of a number
- this can be expressed with 4 rules; t ::=

1. 0
2. successor t
3. predecessor t 
4. iszero t

In our definition, we have term's normal forms that aren't values, e.g. `succ true`
- these are called **stuck**, a notion of run-time error


### 3 Untyped Lambda Calculus
OCaml is kind of lot's of syntactic sugar atop lambda calculus

First order logic (forall, exists), there is no procedure for deciding statements. Church proved this, needing to first define what a procedure is.
- lambda calculus helps us formalize reduction by substitution and scope
  - helps prove properties
  - proofs generalize well

3 grammar rules in lambda calculus (ambiguously)
- any variable is a term
- a term can be formed with a lambda, its parameter, dot (syntactic separator), and another term t
- terms can be a function application; f(x), (f x)
  - left-associative, parathesize to the left conventionally
  
*note concrete syntax tree is just more implementation details*

*formalizing abstract lambda definition is tricky, out of scope*

*truth is a semantic notion, proof is a syntactic notion, and we want to manipulate to prove.*

Abstractions extend as far right as possible

Purely, functions only have one parameter, so functions of multiple parameters must return a function lambda of n -1 parameters. **curried functions**

`λx.t`, we call x **a binder** whose scope does not extend beyond t
- `λx.λx.x` parsed `λx.(λx.x)` is a function that ignores its argument and returns the identity function

`λx.y`, `y` is free because it is not bound

We can recursively define the set of bound variables of an expression because the grammar is recursive:

1. BV[x] = empty
2. BV[ λx.t ] = BV[t] u {x}
3. BV[ t t ] = BV[t1] u BV[t2]

*notice this is just our three grammar rules*

A variable can be both free and bound if there are multiple occurences in different scopes
- name of a binder does not matter, so we need to formalize substitution
- `[x|-> t2] t1` indicates substituting t2 for x in t1
  - we can now define step relation in lambda calculus
- example, `(λx.zx)y` should simplify to `zy`
  - this desire is formalized as `(λx.t1)t2 -> [x |-> t2] t1`

Substitution rule gotchas

1. we need a case that doesn't touch bound variables
2. if our term substitution `s` contains free variables, they must not be bound by a lambda after substitution
  - inadvertent capture of free variables
  - solved with change of variables to a "fresh variable"

This definition of substitution gives us **alpha equivalence**, `=a` 
- so long as y isn't a free variable, `λx.t =a `

β-reduction is `(λx.t1) t2 ->β [x |-> t2] t1`, *notice it just says passing a function an argument is equivalent to substitution in its term*
- **redex** (beta reducable expression), is a subterm of the form `(λx.t1) t2`, a function application
  - several reduction strategies
- **full beta reduciton** allows reduction of any redex, we lose determinacy

Two redecies:
```
(λx.(λy.x)z)w
    1-------
2------------

If redex 1 first:
(λy.w)z

If 2:
(λx.x)w

But they're the same
```

*The rules for full beta reduction says perform any beta reduction in the expression you want*

**Confluence**, not every term has a normal form:

`(λx.xx)(λx.xx)` one step beta reduces to itself (since `x = (λx.xx)`, for x x)

- confluence theorem roughly says that if you can beta reduce divergently, you can bring them back together to a unique normal form
  - normal forms are unique is a consequence of the confluence theorem
- diamond property doesn't hold (some operations simplify the number of steps taken, but doesn't affect normal form still)
  - instead we need to define a form of parallel reduciton, where the diamond property holds
  - finally show that the multi-step relation (transitive closure) for parallel beta reduction is equivalent to full beta-reduction

`(λz.w)((λy.yy)(λy.yy))` can reduce forever if we try to first reduce the argument, or reduce in one step if we reduce the lambda.

**Standardizaiton Theorem** says the repeatedly reducing the leftmost outermost redex will find a normal form if it exists. It's called **normal order reduction** and is deterministic, unlike full beta reduction in general.

```
(λz.w)((λy.yy)(λy.yy))
       1-------------
2---------------------
2 is the outermost (in this case also leftmost)
```

**Call by name** is like normal order, but does not reduce in the body of abstractions
- this avoids variable capture but is inefficient

Haskell is lazy eval version of call-by-name, call-by-need

**Call-by-value** strict and eager, is leftmost, innermost
- first, substitute values

### Programming in Lambda Calculus
We use symbols to represent familiar notions.

To use conditionals, if B then T else F, we can say if some complex statement B simplifies to `λx.λy.x` it's true, and `λx.λy.y` is false

cons consumes two arguments,
f and r, and produces a function
consuming a message. This function
produced represents a list, where 
based on a sort of control bool
that we pass into it, returns either
first or rest of the list,
recursively defining a list as we 
know it.

[**Natural Numbers** p 60](https://cs.uwaterloo.ca/~plragde/442/slides/03-untyped-lambda.pdf)
- idea: code up by eliminator
- Church numerals
- 3 is something that does something 3 times
  - "apply s to z, n times"

test:
```
λ
```

**General Recursion** p 64
- `?` needs to be something that produces `fact`, let's stick a variable there and call it `r`, and stick a `lambda r` at the start

x = f(x), then x is a fixed point of f, nothing happens

for pfact, we need to compute the fixed point (`fact`) of `pfact`

suppose `fact = Y pfact`, then
```
fact = pfact fact 
fact = Y pfact
Y f = f (Y f)
```

forall f.

Can't substitute pfact into r because the function signature would be wrong in the recursive call


we end up with this cool definition of `pfact'` (protofactorial) which when applied to itself, produces `pfact' pfact'` as a recursive call

finally, rearranging

Y combinator doesn't work with call by value?

```
Y = λf. (
Y g = (λr.g(r r))(λr.g(r r)) // call by value FORCES (r r) to evaluate first
// normal order reduction DOES work though
```

We have to stop this evaluation
- call by value doesn't reduce in the body of an abstraction
- let's wrap it in an abstraction: `(r r) = λx.(r r) x`, now it needs to be applied before it get's reduced
  - this can be used equivilently, but SYNTACTICALLY it is different
  - `f` replaced with `λx.f x` is called η-expansion 
- Normal Order Reduction and call-by-value are two lazy ways to perform reduction

variables? we take out λ. ??? well we re-introduce some combinators. *These give us ways to still represent functions I guess?*

#### de Bruijn (brown) indices p 74
replace terms with numbers based on their function call DEPTH
- this is "lexical depth relative to its binding occurrence", *binding occurrence is where λx appears*
- sometimes indices need to be shifted?

### 4 OCaml
Meta language, for theorem provers. It was supposed to be used to express a proof and mechanical step through it to verify
- talked about syntax, ocaml has type inference, but we can explicitly state types
- user-defined types with algebraic datatype definition is pretty cool, playing cards example
  - can't just `|`-together types, each disjunct needs to have a constructor defined for it (prevents type ambiguity)
    - unambiguous types is what makes static type inferencing work
    - so we get things like `type iors = Int of int | String of string;;`, where `Int` is an arbitrarily named constructor, so it acts as a label so we can distiguish `Int 6` as an `: iors = 6` vs `6` is an `: int = 6`
  - constructors are not subtypes
- types that look the same are not 
- option type: `type 'a option = None | Some of 'a`
- records: `let p = {x = 5 ; y = 2};;`
- file by default exports its function definitions, `Stack.pop` 
- interface is used to check, not infer

### 5 Types
Look at the parse tree of the expression rather than dynamic evaluation of the expression
- can distinguish stuck expressions from valid ones
- `t:T` is pronounced "t has type T"
- if `t` is typable, then its type is unique and there is only one derivation
  - terms can make **progress** and preserve types
- progress says if `t:T`, then either `t` is a value or there is some `t'` s.t. `t->t'`
- preservation says if `t:T` and `t->t'`, then `t':T`
- progress + preservation is type safety
- **strong normalization theorem** says: every reduction of every well-typed term in the simply-typed lambda calculus is of finite length
  - suggests that simply-typed lambda calc is a weak model of computation

### 6 Extension to Lambda Calculus
Type rules for sum types:
- figuring out how to type an element of a subtype (like Int+Bool) isn't straight foward
  - OCaml requires unique constructors as we say to fix this
- inject left (`inl`) and right (`inr`) to express which side the type satisfies
- `inl 5 as Nat+Bool` is an annotation to help the type checker figure out what type it is

General Recursion

```
pfact r n = if n == 0 then 
            else n * r r (n - 1)
```

### 7 Type Inference
- type inference treats uninterpreted types as type variables,
- we introduce type substitutions, sigma, which is a map from type variables {A, B, ...} to types {Nat, Bool}
  - descend into terms, and substitute
  - we'll borrow composition notation from other courses: (f o g) x = f ( g x ), this is two sets of substitution for mappings in both f and g
- formally then, **type inference** is given context and a term (GAMMA, t), finding some solution (sigma substitution, output type T) s.t. substitution applied to GAMMA infers that term t is of type T
  - think about sigma as a set of values with types, they may not substitute ALL variables as in algebra we still might have unknowns after substituting one variable.

so let's look at typing currently untyped terms.

λx:A.λy:B.x has an obvious return type A

λx.λy.y x is not typable, you need to substitute before you can type the expression (in other words, there's lots of possible types?)

**Algorithms** work by structural recursion on the term t.

1. recursively find substitutions that types subterms, then add it as a result of the relationship between subterms. 
2. accumulate **constraints**, equations involving variables, then solve the system of equations. In practice, easier to prove and optimize and extend

#### Algorithm W
Consumes the context and term, and produces the inferred type and the set of substitutions

given an untyped term t, annotate each abstraction var x, with a fresh type variable X, and record teh association x:X in context GAMMA

We need three inference rules to do this, one for each possible way t can be formed

1. if t is just a var, all we can do is look it up in GAMMA
2. abstraction. We want to show that it has some form of X -> T (X is a type variable, T is some concrete type). By doing so, we don't add anything to our substitution map sigma. That only happens in application (where substitution intuitively happens)
3. application. we want to show that application has some type T, GAMMA |- t1 t2 : T. We need as premises the fact that t1 is some mapping for a types (T' -> T) for some substitution sigma1, and ALSO that t2 is of type T' with some other substitution sigma2 so that the expression is well typed. 
- interestingly, we need to use information from the first inference on t1 in order to type t2. We have to apply sigma1 to GAMMA context in our second expression when inferring t2.
- write this as an algebraic equation, T1 = T2 -> X, where X is fresh. Again this is just saying that t1 : T1 must be abstraction, a mapping of one type to another. Then we must infer X by solving the equation. Taking these two expressions and making an equation is **unification**, saying they're the same. The **unifier** is the substitution that solve it such that `sigma T1 = sigma T2`

#### Constraint-based type inference
First accumulates type constraints and then finds substitutions that satisfy them.
- A constraint set C is a set of equations {Si = Ti}

1. for variables, no constraints
2. for abstractions, annotation is in the context
3. for application, simpler because we don't need this substitution as we go. Instead, we throw everything in C instead of sigma, and accumulate all type relations with equations.

Now we need to solve the system of equations. A solution for a problem (Γ, t, S, C) is a pair (σ, T) such that
σ unifies C and σS = T

We want **soundness** and **completeness** as properties
- soundness, if we get a solution, it's correct
- completeness, if there's an answer, this approach finds it

##### Solving Constraint Set
Recursive definition of the `unify()` operation, where unify in the context of constraint-based type inference is the operation of solving a system of equations
- unify will take a set of constraints, and return the set of substitutions
- a **principal unifier** is less general than any other unifier
- theroem 22.4.5.3 says `unify(C)` will produce the principal unfier, the best one

#### Polymorphism
Problem arises now when we use polymorphic functions. Applying them to data, they get specialized. 

Let-polymorphism uses type reconstruction as above, and generalizes it to provide a simple form of polymorphism. 
- idea 1: perform substitution (expensive)
- idea 2: type `id` as forall X. X -> X
  - quantifiers are all internal
  - quantifiers are only permitted at the top of a type expression
  - we say a type variable occurs free in a type environment Γ if it is not quantified there.
  - Quantifier elimination just says if a var is in the env Γ, then immediately substitute with a fresh variable
  
### 8 Haskell and Laziness
`take 1 $ qsort` will be worst case O(n^2)

`take 1 $ msort` will be worst case O(n) because it will lazily only look at the first element of each subproblem, and O(m log n) for `take m` since we just need to find replacements to the element we removed from the possible smallest elements, one at each height for each iteration

```
foldr c b [] = b
foldr c b (x:xs) = c x (foldr c b xs)
```
looking at space complexity:
```
foldr (+) 0 [1,2,3,...,n]
1 + (2 + (3 + (... + (n + 0))))
      O(n) space
```      

but foldl is tail recursive (using tail call optimization) in an eager language:

```
foldl (+) 0 [1,2,3,...,n]
((((0 + 1) + 2) + 3) + ... + n)
    O(1) space in eagar
    O(n) space in lazy
```

### 9 Types in Haskell
Type classes in Haskell offer a
controlled approach to "ad hoc overloading".

we want one particular name to mean different things in different contexts
- provide simple solution with enough generality that these type classes can be used for a bunch of different things
- can create an instance of a type class (take certain function signatures, and write something that implements the same signature)

#### Some basic classes
##### `Eq`
`Eq` are types with the notion of equality
- ``` `==` ```and``` `/=` ``` operators

`deriving` keyword gives you default behaviour. 

```
data Btree a =
  Empty
| Node (Btree a) a (Btree a)
  deriving Eq
```

This is the obvious structural equality.

We can also define non-default equality be explicitly defining our own equality.

```
data First = Pair Int Int
instance Eq First where
(Pair x _) == (Pair y _) = (x==y)
(Pair 1 3) == (Pair 2 3)
> False
(Pair 1 3) == (Pair 1 4)
> True
```

##### `Ord`
Inherits from Eq, specifies `<`, `>`, `<=`, `>=`, default defn of `min` and `max`, `compare`

```
msort :: (Ord a) => [a] -> [a]

can be read as, msort has type list to list s.t. a derives Ord
more generally:
fcn-name :: constraints => type signature
```

##### `Show`
specifies the method `show :: a -> String` and `read :: String -> a` which is a simple parser (crazy cool)

#### Implementaiton of type classes
Simply a dictionary of operators to their function signatures

Code defining Num:

```
class Num a where
  (+), (*) :: a -> a -> a
  negate :: a -> a
```

Then under the hood, the compiler conceptually creates the following:

```
data NumDict a
= MkND (a -> a -> a)
       (a -> a -> a)
       (a -> a)
plus  (MkND p _ _) = p
times (MkND _ t _) = t
neg  (MkND _ _ n) = n
```

Again, it's really just a hidden dictionary.

#### [More Useful Type Classes](http://learnyouahaskell.com/functors-applicative-functors-and-monoids)
Haskell's purity, higher order functions, and parameterized algebraic data types let us implement polymorphism at a "higher level" than any other language. Type classes alow us to describe behavior of types. Again, in the previous section we have type classes like `Eq` that describe classes that can perform equaltiy checks. Here are more powerful type classes.

1. Monoid in math is a set with an identity and an associative (bracketable any way) binary operation
  - integers with 0 and `+`
  - list with `[]` and `++` (more generalizable, so more useful)

```haskell
class Monoid a where
  mempty :: a
  mappend :: a -> a -> a
  mconcat :: [a] -> a
  mconcat = foldr mappend mempty
```

2. The functor class is motivated by the awkward use of `Maybe`, and can be used for lists. It can be used ot represent higher-order concepts like lists. Broadly, functors are things that can be mapped over, and this is reflected by the definition which simply provides an interface for `fmap`

```haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b

{- notice there is no default implementation of fmap -}
{- also notice that f is not a concrete type that holds a value, 
   but rather a type constructor that takes one type as the parameter -}

instance Functor [] where  
    fmap = map  

{- the type signature for map is: -}
map :: ( a -> b ) -> [a] -> [b]

{- so the above instance of list above is correct! where: -}
f = []

instance Functor Maybe where
  fmap _ Nothing = Nothing
  fmap g (Just a) = Just (g a) {- unwrap and wrap again in another Just -}
```

3. Kinds help us handle two arguments?
  - Kind of bool (or other concrete type) is `*`. think of it as a type constant, type constructor with 0 arguments
  - Kind of Maybe and [] (or other single argument type constructors) is `* => *`
  - `,` and `->` have kind `* => * => *` 
  - notice they have the wrong type to be a functor (too many arguments) so we need to provide the first arugment

In class example:
```haskell
instance Functor ((->) r) where
  fmap = (.)

now we have f makes an r -> ?
from above,
fmap :: (a -> b) -> f a -> f b
so when f = ((->) r),

(a -> b) -> (r -> a) -> (r -> b)
   f           g

composition?
```

Another "more useful" example:

```
instance Functor ((,) w) where
  fmap f (w,a) = (w, f a)

```

Still kind of weird and limited, since we only have one argument functors. If you want to partially apply a function to the second argument, then we can simply wrap it in some `newtype` that flips the arguments and overrides the `fmap` definition to unswap accordingly.

Functor laws: 

```
fmap id = id
fmap (g . h) = fmap g . fmap h
```

4. The **Applicative class** has less power than monads by design

```
class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
```

- `<*>` pronounced "applied" maybe?
- Recall function application `($) :: (a -> b) -> a -> b`
- notice that `applied` is very close to the actual application operator
- `Maybe`, `[]`, `((->) r)` and `((,) w)` are all instances of `Applicative`
- Applicative f has kind ```* => *```

Looking at an example of `Maybe`:

```haskell
instance Applicative Maybe where
  pure = Just                       {- implementing Applicative interface -}
  Nothing <*> _ = Nothing
  _ <*> Nothing = Nothing
  (Just f) <*> (Just y) = Just (f y)

fmap (+) (Just 2) <*> (Just 3)
> Just 5
(+) <$> (Just 2) <*> (Just 3)
> Just 5
pure (+) <*> (Just 2) <*> (Just 3)
> Just 5
```

So notice we're "lifting" things into `Maybe`, kind of just general definitions of operators that let us perform optional things within the `Maybe` type
- `pure` lifts a function up, making it a `Maybe` compatible function by writing ```pure f <*>``` instead of ```f <$>```

#### Revisiting the Monad class
Again, monads are more powerful than applicatives:

```haskell
class Applicative m => Monad m where
  (=<<) :: (a -> m b) -> m a -> m b {- produces a value in the context m, from a value a in context m -}
  (>>=) :: m a -> (a -> m b) -> m b {- reversed arguments -}
  (>>) :: m a -> m b -> m b
  m >> n = m >>= \_ -> n
  fail :: String -> m a
  fail s = error s
```

looking at IO example:

### Higher-order Polymorphism: System F
There are varieties of polymorphism, we studied let-polymorphism
- **polymorphism** is a term referring to a range of language mechanics that enable code to be more easily reused
- we can substitute a full copy of the polymorphic expression every time we use it, so that its set of type varialbles are only constrained in its specific application, and doesn't affect other applications (due to alpha renaming)

```
  gamma |- [x |-> t1] t2 : T2
------------------------------- T-LetPoly simple
gamma |- let x = t1 in t2 : T2
```

But we can pass garbage into the value for x and if it's not used in t2, it won't be type checked, so we need to add the extra premise to check this:

```
gamma |- [x |-> t1] t2 : T2    gamma |- t1 : T1
-----------------------------------------------
       gamma |- let x = t1 in t2 : T2
```

Let-polymorphism only allows top level let-bindings, "disallows functions that take polymorphic values as arguments"?

System F introduce quantifiers. `(lambda X.t)[T] -> [X |-> T]t` is a type application. The pair of a type application and type abstraction forms a redex analogous to normal app-abs pairs.
- the forall quantifier lets us type the identity function, `id id :: forall X.X -> X`
- we could not type `lambda x.x x` in the simple typed calculus but we can in System F
- the core intermediate language of GHC is based on System F
- GHC core is explicitly typed

#### Theorems
Type checking is still simple structural recursion, so progress and preservation theorems apply.
- type inference is undecidable 
- *still useful in practice using a subset of it*

#### Programming
We need to still encode booleans and integers to make it useful. *We use these encodings to allow us to leverage structural properties of the simple definition of our language, while making it expressive using these encodings*

Again, a boolean is `lambda x. lambda y. x :: X -> X -> X`. This can be expressed instead as `forall X . X -> X -> X` in system F.

Natural numbers consume a successor and zero: `Nat :: forall X . (X -> X) -> X -> X`, where `X->X` is the type of a successor.
