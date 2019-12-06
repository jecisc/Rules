# Rules's documentation

`Rules` is a small and simple project to manage rules. 

This project provides objects to represent rulesto not violate on a model and allows one to run them on a model to get the entities violation them and to get the technical debt of the project.


- [Quick start](#quick-start)
- [Design](#design)
- [Rules](#rules)
  * [RuCompositeRule](#rucompositerule)
  * [RuRulesManager](#rurulesmanager)
  * [RuRule](#rurule)
  * [RuQueryRule](#ruqueryrule)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


## Quick start

To create a batch of rules to run on a model you first need to create a `RuRulesManager`.

A rule manager is a composite rule that will know the model which the rules should apply and that contains all the rules.

```Smalltalk
model := #(2 4 6 8 11 14).

rulesManager := RuRulesManager
	labelled: 'My number collection rules'
	explanation: 'This composite rule contains all the constraits my collection of numbers should respect.'
	model: model.
```

Then we can add our rules.

```Smalltalk
rulesManager
	addRule:
		(RuRule
			rule: [ :model | model select: #odd ]
			label: 'No odd number'
			explanation: 'In my collection of number I do not want any odd numbers (Because they are too odd...)'
			remediationTime: 30 seconds);
	addRule:
		(RuRule
			rule: [ :model | model select: #isPrime ]
			label: 'No prime'
			explanation: 'In my collection of number I do not want any prime numbers.'
			remediationTime: 1 minute).
```

And then get informations from those rules.

```Smalltalk
rulesManager technicalDebt.  "0:00:02:30"

rulesManager violations. "a Set(11 2)"

String
	streamContents: [ :s | 
		rulesManager listAllRules
			do: [ :rule | 
				s
					nextPutAll: rule label;
					nextPutAll: ': ';
					nextPutAll: rule explanation;
					lf;
					nextPutAll: 'Remediation time: ';
					print: rule totalRemediationTime;
					lf;
					nextPutAll: 'Violations:';
					lf.
				rule violations
					do: [ :v | 
						s
							nextPutAll: '- ';
							print: v ]
					separatedBy: [ s lf ].
				s
					lf;
					lf ] ]

"'No odd number: In my collection of number I do not want any odd numbers (Because they are too odd...)
Remediation time: 0:00:00:30
Violations:
- 11

No prime: In my collection of number I do not want any prime numbers.
Remediation time: 0:00:02:00
Violations:
- 2
- 11

'"
```

## Design

![UML of the project](uml.png?raw=true "UML of the project")

This project is based on the [Composite design pattern](https://en.wikipedia.org/wiki/Composite_pattern).
A `RuRootRule` is a composite containing instances of `RuLeafRule`.

## Rules

The project contains different kind of rules.

### RuCompositeRule 

A `RuCompositeRule` is a rule containing other rules.

It can return the entities violating one of those rule with the `#violation` method and the technical debt in days via `#technicalDebt`.

### RuRootRule

A `RuRootRule` is a specialization of `RuCompositeRule`. This is a composite that also knows the model on which the rules should be run. 

### RuRule

A `RuRule` is a rule configured with a valuable (such as a Block). This valuable takes the model as parameter and should return the entities from the model violation the rule.

### RuQueryRule

A `RuQueryRule` is a rule configured with a Query object. This query should use the Trait `RuTQuery`. 

The rule will delegate the computation of violations to the query and consider the result of this query as the entities violation the rule.
