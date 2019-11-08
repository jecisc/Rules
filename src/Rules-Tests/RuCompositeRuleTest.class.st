"
A RuCompositeRuleTest is a test class for testing the behavior of RuCompositeRule
"
Class {
	#name : #RuCompositeRuleTest,
	#superclass : #RuAbstractRuleTest,
	#category : #'Rules-Tests'
}

{ #category : #helpers }
RuCompositeRuleTest >> actualClass [
	^ RuCompositeRule
]

{ #category : #helpers }
RuCompositeRuleTest >> mutate: aRule [
	aRule children anyOne ruleBlock: [ :aModel | aModel allContainers select: [ :each | each numberOfLinesOfCode > 100 ] ]
]

{ #category : #helpers }
RuCompositeRuleTest >> newInstance [
	| inst |
	inst := super newInstance.
	"3 violations"
	self
		query: 'Long Containers'
		meaning: 'Containers should not be longer than 6 lines of code'
		as: [ :aModel | aModel allContainers select: [ :each | each numberOfLinesOfCode > 6 ] ]
		remediationTime: 5
		for: inst.
	"0 violations"
	self
		query: 'Complexity of Functions'
		meaning: 'Containers should not be complex: average cyclomatic complexity of more than 10'
		as: [ :aModel | aModel allContainers select: [ :each | each averageCyclomaticComplexity > 10 ] ]
		remediationTime: 10
		for: inst.
	"2 violations"
	self
		query: 'Duplicate Containers'
		meaning: 'Containers should not have duplicate code'
		as: [ :aModel | aModel allContainers select: #hasDuplicatedCode ]
		remediationTime: 15
		for: inst.
	"1 violations"
	self
		query: 'Dead Containers'
		meaning: 'Containers should not be dead (i.e. not invoked in the system)'
		as: [ :aModel | aModel allContainers select: #containsDeadEntities ]
		remediationTime: 20
		for: inst.
	^ inst
]

{ #category : #helpers }
RuCompositeRuleTest >> query: aLabelString meaning: aMeaningString as: aBlock remediationTime: time for: parent [
	^ parent
		addRule:
			(RuRule
				ruleBlock: aBlock
				label: aLabelString
				explanation: aMeaningString
				remediationTime: time)
]

{ #category : #tests }
RuCompositeRuleTest >> testAddRule [
	| rules newRule |
	rules := rule children copy.
	newRule := RuRule new
		label: 'test';
		explanation: 'test 2';
		ruleBlock: [ true ];
		remediationTime: 10;
		yourself.
	rule addRule: newRule.
	self assert: rule children size equals: rules size + 1
]

{ #category : #tests }
RuCompositeRuleTest >> testAddRuleSetParent [
	| newRule |
	newRule := RuRule new
		label: 'test';
		explanation: 'test 2';
		ruleBlock: [ true ];
		remediationTime: 10;
		yourself.
	self assert: newRule parent isNil.
	rule addRule: newRule.
	self assert: newRule parent equals: rule
]

{ #category : #tests }
RuCompositeRuleTest >> testCompositeRuleWithoutChildren [
	rule children removeAll.
	self shouldnt: [ rule totalRemediationTime ] raise: Error.
	self assert: rule totalRemediationTime equals: Duration zero
]

{ #category : #helpers }
RuCompositeRuleTest >> totalRemediationTime [
	^ Duration minutes: 65
]
