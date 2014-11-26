"
Abstract, do not run.
"
Class {
	#name : #XMLNodeWithChildrenTest,
	#superclass : #XMLNodeTest,
	#category : #'XML-Tests-Parser-DOM'
}

{ #category : #testing }
XMLNodeWithChildrenTest class >> isAbstract [
	^ true
]

{ #category : #'instance creation' }
XMLNodeWithChildrenTest >> newNodeWithNodes [
	^ self nodeClass new
		addNode: (XMLComment string: 'one');
		addNode: (XMLPI target: 'two' data: 'three');
		addNode: (XMLComment string: 'four');
		addNode: (XMLPI target: 'five' data: 'six');
		yourself
]

{ #category : #accessing }
XMLNodeWithChildrenTest >> nodeClass [
	^ XMLNodeWithChildren
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAddNode [
	| node nodeWithNodes added |

	node := self nodeClass new.
	nodeWithNodes := self newNodeWithNodes.
	added := OrderedCollection new.
	10 timesRepeat: [
		added add: self nodeClass new.
		self
			assert: (node addNode: added last) == added last;
			assert: (node lastNode) == added last.
		self
			should: [nodeWithNodes addNode: added last]
			raise: XMLDOMException].
	node nodes asOrderedCollection = added.

]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAddNodeAfter [
	| nodeWithNodes added |

	nodeWithNodes := self newNodeWithNodes.
	added := OrderedCollection new.
	nodeWithNodes nodes copy do: [:each |
		added
			add: each;
			add: self nodeClass new.
		self
			assert: (nodeWithNodes addNode: added last after: each) == added last;
			assert: (nodeWithNodes nodeAfter: each) == added last.
		self
			should: [nodeWithNodes addNode: each after: each]
			raise: XMLDOMException].
	nodeWithNodes nodes asOrderedCollection = added.

]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAddNodeBefore [
	| nodeWithNodes added |

	nodeWithNodes := self newNodeWithNodes.
	added := OrderedCollection new.
	nodeWithNodes nodes copy do: [:each | | node |
		added
			add: (node := self nodeClass new);
			add: each.
		self
			assert: (nodeWithNodes addNode: node before: each) == node;
			assert: (nodeWithNodes nodeBefore: each) == node.
		self
			should: [nodeWithNodes addNode: each before: each]
			raise: XMLDOMException].
	nodeWithNodes nodes asOrderedCollection = added.

]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAddNodeFirst [
	| node nodeWithNodes added |

	node := self nodeClass new.
	nodeWithNodes := self newNodeWithNodes.
	added := OrderedCollection new.
	10 timesRepeat: [
		added addFirst: self nodeClass new.
		self
			assert: (node addNodeFirst: added first) == added first;
			assert: (node firstNode) == added first.
		self
			should: [nodeWithNodes addNodeFirst: added first]
			raise: XMLDOMException].
	node nodes asOrderedCollection = added.

]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAddNodes [
	| node nodeWithNodes added |

	node := self nodeClass new.
	nodeWithNodes := self newNodeWithNodes.
	added := OrderedCollection new.
	1 to: 10 do: [:i | | nodes |
		nodes := (1 to: i) collect: [:each | self nodeClass new].
		added addAll: nodes.

		self assert: (node addNodes: nodes) == nodes.
		nodes do: [:each |
			self assert: (node includesNode: each).
			self
				should: [nodeWithNodes addNode: each]
				raise: XMLDOMException]].

	node nodes asOrderedCollection = added.

]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodes [
	| nodeWithNodes allNodes |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		assert: allNodes size = 5;
		assert: allNodes first == nodeWithNodes;
		assert: allNodes second isComment;
		assert: allNodes second string = 'one';
		assert: allNodes third isPI;
		assert: allNodes third target = 'two';
		assert: allNodes third data = 'three';
		assert: allNodes fourth isComment;
		assert: allNodes fourth string = 'four';
		assert: allNodes fifth isPI;
		assert: allNodes fifth target = 'five';
		assert: allNodes fifth data = 'six'.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesCollect [
	| nodeWithNodes allNodes |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		assertList: (nodeWithNodes allNodesCollect: [:each | each identityHash])
		collects: (allNodes collect: [:each | each identityHash]).

	allNodes do: [:node |
		node canHaveChildren
			ifTrue: [
				self
					assertList: (node allNodesCollect: [:each | each identityHash])
					collects: (node allNodes collect: [:each | each identityHash])]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesDetect [
	| nodeWithNodes allNodes detectedNode |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	detectedNode := nodeWithNodes allNodesDetect: [:each | each isPI].
	self
		assert: detectedNode notNil;
		assert: detectedNode isPI;
		assert: detectedNode == (allNodes detect: [:each | each isPI]);
		assert: (nodeWithNodes allNodesDetect: [:each | each isElementNamed: 'absent']) isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesDetectIfNone [
	| nodeWithNodes allNodes detectedNode |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	detectedNode :=
		nodeWithNodes
			allNodesDetect: [:each | each isPI]
			ifNone: [#absent].
	self
		deny: detectedNode = #absent;
		assert: detectedNode isPI;
		assert: detectedNode == (allNodes detect: [:each | each isPI] ifNone: [#absent]);
		assert:
			(nodeWithNodes
				allNodesDetect: [:each | each isElementNamed: 'absent']
				ifNone: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesDo [
	| nodeWithNodes allNodes |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		should: [:block | nodeWithNodes allNodesDo: block]
		enumerate: allNodes.

	allNodes do: [:node |
		node canHaveChildren
			ifTrue: [
				self
					should: [:block | node allNodesDo: block]
					enumerate: node allNodes]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAllNodesSelect [
	| nodeWithNodes allNodes |

	nodeWithNodes := self newNodeWithNodes.
	allNodes := nodeWithNodes allNodes.
	self
		assertList: (nodeWithNodes allNodesSelect: [:each | each isComment])
		selects: (allNodes select: [:each | each isComment]).

	allNodes do: [:node |
		node canHaveChildren
			ifTrue: [
				self
					assertList: (node allNodesSelect: [:each | each isComment])
					selects: (node allNodes select: [:each | each isComment])]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAncestorNodes [
	| nodeWithNodes ancestorStack |

	nodeWithNodes := self newNodeWithNodes.
	ancestorStack := OrderedCollection new.
	nodeWithNodes allNodesDo: [:each |
		[ancestorStack isEmpty
			or: [ancestorStack last == each parent]]
			whileFalse: [ancestorStack removeLast].
		self assert:
			each ancestorNodes asOrderedCollection =
				ancestorStack reversed.
		ancestorStack addLast: each].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testAncestorNodesDo [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes allNodesDo: [:each |
		self
			should: [:block | each ancestorNodesDo: block]
			enumerate: each ancestorNodes].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testCanHaveChildren [
	self assert: self nodeClass new canHaveChildren
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testCopy [
	| nodeWithNodes nodeWithNodesCopy unvisitedPairs visitedPairs copiedTypes |

	super testCopy.
	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodesCopy := nodeWithNodes copy.
	self
		assert: nodeWithNodes printString = nodeWithNodesCopy printString;
		assert: nodeWithNodes allNodes size = nodeWithNodesCopy allNodes size.

	unvisitedPairs := Set new.
	nodeWithNodes allNodes
		with: nodeWithNodesCopy allNodes
		do: [:node :nodeCopy | unvisitedPairs add: node -> nodeCopy].

	visitedPairs := Set new.
	copiedTypes :=
		#(OrderedCollection Dictionary OrderPreservingStringDictionary
			XMLNode XMLNamespaceScope XMLOrderedList)
			collect: [:each | Smalltalk at: each].
	[unvisitedPairs isEmpty]
		whileFalse: [ | pair originalObject copyObject |
			pair := unvisitedPairs remove: unvisitedPairs anyOne.
			originalObject := pair key.
			copyObject := pair value.

			self deny: originalObject == copyObject.
			visitedPairs add: pair.
			1 to: originalObject class instSize do: [:i | | newPair |
				newPair := (originalObject instVarAt: i) -> (copyObject instVarAt: i).
				((visitedPairs includes: newPair)
					or: [copiedTypes noneSatisfy: [:each | newPair key isKindOf: each]])
					ifFalse: [unvisitedPairs add: newPair]]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodes [
	| nodeWithNodes descendentNodes |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	self
		assertList: descendentNodes
		selects: nodeWithNodes allNodes allButFirst.

	descendentNodes do: [:node |
		node canHaveChildren
			ifTrue: [
				self
					assertList: node descendentNodes
					selects: node allNodes allButFirst]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesCollect [
	| nodeWithNodes descendentNodes |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	self
		assertList: (nodeWithNodes descendentNodesCollect: [:each | each identityHash])
		collects: (descendentNodes collect: [:each | each identityHash]).

	descendentNodes do: [:node |
		node canHaveChildren
			ifTrue: [
				self
					assertList: (node descendentNodesCollect: [:each | each identityHash])
					collects: (node descendentNodes collect: [:each | each identityHash])]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesDetect [
	| nodeWithNodes descendentNodes detectedNode |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	detectedNode := nodeWithNodes descendentNodesDetect: [:each | each isPI].
	self
		assert: detectedNode notNil;
		assert: detectedNode isPI;
		assert: detectedNode == (descendentNodes detect: [:each | each isPI]);
		assert: (nodeWithNodes descendentNodesDetect: [:each | each isElementNamed: 'absent']) isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesDetectIfNone [
	| nodeWithNodes descendentNodes detectedNode |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	detectedNode :=
		nodeWithNodes
			descendentNodesDetect: [:each | each isPI]
			ifNone: [#absent].
	self
		deny: detectedNode = #absent;
		assert: detectedNode isPI;
		assert: detectedNode == (descendentNodes detect: [:each | each isPI] ifNone: [#absent]);
		assert:
			(nodeWithNodes
				descendentNodesDetect: [:each | each isElementNamed: 'absent']
				ifNone: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesDo [
	| nodeWithNodes descendentNodes |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	self
		should: [:block | nodeWithNodes descendentNodesDo: block]
		enumerate: descendentNodes.

	descendentNodes do: [:node |
		node canHaveChildren
			ifTrue: [
				self
					should: [:block | node descendentNodesDo: block]
					enumerate: node descendentNodes]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDescendentNodesSelect [
	| nodeWithNodes descendentNodes |

	nodeWithNodes := self newNodeWithNodes.
	descendentNodes := nodeWithNodes descendentNodes.
	self
		assertList: (nodeWithNodes descendentNodesSelect: [:each | each isComment])
		selects: (descendentNodes select: [:each | each isComment]).

	descendentNodes do: [:node |
		node canHaveChildren
			ifTrue: [
				self
					assertList: (node descendentNodesSelect: [:each | each isComment])
					selects: (node descendentNodes select: [:each | each isComment])]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testDocument [
	| nodeWithNodes document |

	nodeWithNodes := self newNodeWithNodes.
	document := nodeWithNodes document.
	nodeWithNodes allNodesDo: [:each |
		self assert: each document == document].

	document
		ifNotNil: [ | root |
			root := document root.
			document removeNodes.
			root allNodesDo: [:each |
				self assert: each document isNil]].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testFirstNode [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes nodes copy do: [:each |
		self  assert: nodeWithNodes firstNode == each.
		nodeWithNodes removeNode: each].
	self assert: nodeWithNodes firstNode isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testHasChildren [
	super testHasChildren.

	self assert: self newNodeWithNodes hasChildren.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testIncludesNode [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes nodes do: [:each |
		self assert: (nodeWithNodes includesNode: each)].
	self deny: (nodeWithNodes includesNode: self nodeClass new).
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testLastNode [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes nodes reversed do: [:each |
		self  assert: nodeWithNodes lastNode == each.
		nodeWithNodes removeNode: each].

	self assert: nodeWithNodes lastNode isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNextNode [
	| nodeWithNodes nextNode |

	super testNextNode.
	nodeWithNodes := self newNodeWithNodes.
	nextNode := nil.
	nodeWithNodes nodes reverseDo: [:each |
		self assert: each nextNode == nextNode.
		nextNode := each].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodeAfter [
	| nodeWithNodes nodeAfter |

	nodeWithNodes := self newNodeWithNodes.
	nodeAfter := nil.
	nodeWithNodes nodes reverseDo: [:each |
		self assert: (nodeWithNodes nodeAfter: each) == nodeAfter.
		nodeAfter := each].
	self assert: (nodeWithNodes nodeAfter: self nodeClass new) isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodeAt [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	self assert: (nodeWithNodes nodeAt: 0) isNil.
	1 to: nodeWithNodes nodes size do: [:i |
		self assert: (nodeWithNodes nodeAt: i) == (nodeWithNodes nodes at: i)].
	self assert: (nodeWithNodes nodeAt: nodeWithNodes nodes size + 1) isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodeAtIfAbsent [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	self assert: (nodeWithNodes nodeAt: 0 ifAbsent: [#absent]) = #absent.
	1 to: nodeWithNodes nodes size do: [:i |
		self assert:
			(nodeWithNodes
				nodeAt: i
				ifAbsent: [#absent]) == (nodeWithNodes nodes at: i)].
	self assert:
		(nodeWithNodes
			nodeAt: nodeWithNodes nodes size + 1
			ifAbsent: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodeAtPut [
	| nodeWithNodes newNodeClass |

	nodeWithNodes := self newNodeWithNodes.
	newNodeClass := nodeWithNodes firstNode class.
	self
		should: [nodeWithNodes nodeAt: 0 put: newNodeClass new]
		raise: Error.
	1 to: nodeWithNodes nodes size do: [:i | | newNode |
		newNode := newNodeClass new.
		self assert: (nodeWithNodes nodeAt: i put: newNode) == newNode].
	self
		should: [
			nodeWithNodes
				nodeAt: nodeWithNodes nodes size + 1
				put: newNodeClass new]
		raise: Error.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodeBefore [
	| nodeWithNodes nodeBefore |

	nodeWithNodes := self newNodeWithNodes.
	nodeBefore := nil.
	nodeWithNodes nodes do: [:each |
		self assert: (nodeWithNodes nodeBefore: each) == nodeBefore.
		nodeBefore := each].
	self assert: (nodeWithNodes nodeBefore: self nodeClass new) isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodeListCopying [
	| nodeWithNodes nodeListCopy |

	nodeWithNodes := self newNodeWithNodes.
	nodeListCopy := nodeWithNodes nodes copy.
	self
		assert: nodeListCopy = nodeWithNodes nodes;
		deny: nodeListCopy == nodeWithNodes nodes;
		assert: nodeWithNodes nodes observer == nodeWithNodes;
		assert: nodeListCopy observer isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodes [
	self assert: (self nodeClass new nodes isKindOf: XMLNodeList)
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodesCollect [
	| node |

	node := self newNodeWithNodes.
	self
		assertList: (node nodesCollect: [:each | each identityHash])
		collects: (node nodes collect: [:each | each identityHash]).
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodesDetect [
	| node detectedNode |

	node := self newNodeWithNodes.
	detectedNode := node nodesDetect: [:each | each isComment].
	self
		assert: detectedNode notNil;
		assert: detectedNode == (node nodes detect: [:each | each isComment]);
		assert: (node nodesDetect: [:each | each isElementNamed: 'absent']) isNil.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodesDetectIfNone [
	| node detectedNode |

	node := self newNodeWithNodes.
	detectedNode :=
		node
			nodesDetect: [:each | each isComment]
			ifNone: [#absent].
	self deny: detectedNode = #absent.
	self assert:
		detectedNode ==
			(node nodes detect: [:each | each isComment] ifNone: [#absent]).
	self assert:
		(node
			nodesDetect: [:each | each isElementNamed: 'absent']
			ifNone: [#absent]) = #absent.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodesDo [
	| node |

	node := self nodeClass new.
	self should: [:block | node nodesDo: block] enumerate: #().

	node := self newNodeWithNodes.
	self should: [:block | node nodesDo: block] enumerate: node nodes.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testNodesSelect [
	| node |

	node := self newNodeWithNodes.
	self
		assertList: (node nodesSelect: [:each | each hasChildren])
		selects: (node nodes select: [:each | each hasChildren]).
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testPreviousNode [
	| nodeWithNodes previousNode |

	super testPreviousNode.
	nodeWithNodes := self newNodeWithNodes.
	previousNode := nil.
	nodeWithNodes nodes do: [:each |
		self assert: each previousNode == previousNode.
		previousNode := each].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testRemoveNode [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes nodes copy do: [:each |
		self
			assert: (nodeWithNodes includesNode: each);
			assert: (nodeWithNodes removeNode: each) == each;
			deny: (nodeWithNodes includesNode: each)].
	self deny: nodeWithNodes hasChildren.
	self
		should: [nodeWithNodes removeNode: self nodeClass new]
		raise: Error.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testRemoveNodeIfAbsent [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	nodeWithNodes nodes copy do: [:each |
		self
			assert: (nodeWithNodes includesNode: each);
			assert: (nodeWithNodes removeNode: each ifAbsent: [#absent]) == each;
			deny: (nodeWithNodes includesNode: each)].
	self deny: nodeWithNodes hasChildren.
	self assert:
		(nodeWithNodes
			removeNode: self nodeClass new
			ifAbsent: [#absent]) == #absent.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testRemoveNodes [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	self
		assert: nodeWithNodes hasChildren;
		assert: nodeWithNodes removeNodes == nodeWithNodes;
		deny: nodeWithNodes hasChildren.
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testRemoveNodesAll [
	| nodeWithNodes |

	nodeWithNodes := self newNodeWithNodes.
	1 to: nodeWithNodes nodes size do: [:i | | removed |
		removed := (nodeWithNodes nodes copyFrom: 1 to: i).
		self
			assert: (removed allSatisfy: [:each | nodeWithNodes includesNode: each]);
			assert: (nodeWithNodes removeNodes: removed) == removed;
			deny: (removed anySatisfy: [:each | nodeWithNodes includesNode: each]).
		nodeWithNodes := self newNodeWithNodes].
]

{ #category : #tests }
XMLNodeWithChildrenTest >> testReplaceNodeWith [
	| nodeWithNodes replacements |

	nodeWithNodes := self newNodeWithNodes.
	replacements := OrderedCollection new.
	nodeWithNodes nodes copy do: [:each |
		self assert:
			(nodeWithNodes
				replaceNode: each
				with: (replacements add: self nodeClass new)) == replacements last].
	self assert: nodeWithNodes nodes asOrderedCollection = replacements.
]