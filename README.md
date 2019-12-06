# Rules

Rules is a small model of rules that a model should not violate. It is able to compute the technical debt for a set of violations.

[![Build Status](https://travis-ci.org/jecisc/Rules.svg?branch=master)](https://travis-ci.org/jecisc/Rules) [![Coverage Status](https://coveralls.io/repos/github/jecisc/Rules/badge.svg)](https://coveralls.io/github/jecisc/Rules)

  - [Installation](#installation)
  - [Quick start](#quick-start)
  - [Documentation](#documentation)
  - [Version management](#version-management)
  - [Smalltalk versions compatibility](#smalltalk-versions-compatibility)
  - [Contact](#contact)

## Installation

To install Rules on your Pharo image, execute the following script: 

```Smalltalk
Metacello new
	githubUser: 'jecisc' project: 'Rules' commitish: 'v1.x.x' path: 'src';
	baseline: 'Rules';
	load
```

To add Rules to your baseline:

```Smalltalk
spec
	baseline: 'Rules'
	with: [ spec repository: 'github://jecisc/Rules:v1.x.x/src' ]
```

Note you can replace the #master by another branch such as #development or a tag such as #v1.0.0, #v1.? or #v1.2.? .

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

Then we can add our rules. A rule contains mainly a block that takes a model (the "universe") as parameter and returns the collection of entities, within this model, that violate the rule.

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

## Documentation

Documentation can be found [here](documentation/Documentation.md).

## Version management 

This project use semantic versioning to define the releases. This means that each stable release of the project will be assigned a version number of the form `vX.Y.Z`. 

- **X** defines the major version number
- **Y** defines the minor version number 
- **Z** defines the patch version number

When a release contains only bug fixes, the patch number increases. When the release contains new features that are backward compatible, the minor version increases. When the release contains breaking changes, the major version increases. 

Thus, it should be safe to depend on a fixed major version and moving minor version of this project.

## Smalltalk versions compatibility

| Version 	| Compatible Pharo versions 	|
|-------------	|---------------------------	|
| 1.x.x       	| Pharo 61, 70, 80		|

## Contact

If you have any questions or problems do not hesitate to open an issue or contact cyril (a) ferlicot.me 
