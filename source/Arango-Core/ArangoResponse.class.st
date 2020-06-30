Class {
	#name : #ArangoResponse,
	#superclass : #Object,
	#instVars : [
		'hasMore',
		'cached',
		'extra',
		'result',
		'code',
		'error'
	],
	#category : #'Arango-Core-Base'
}

{ #category : #accessing }
ArangoResponse class >> neoJsonMapping: mapper [
	
	mapper
		for: self
		do: [ :mapping | mapping mapInstVars: self instVarNames].
]

{ #category : #accessing }
ArangoResponse >> cached [
	^ cached
]

{ #category : #accessing }
ArangoResponse >> cached: anObject [
	cached := anObject
]

{ #category : #accessing }
ArangoResponse >> code [
	^ code
]

{ #category : #accessing }
ArangoResponse >> code: anObject [
	code := anObject
]

{ #category : #accessing }
ArangoResponse >> data [
	^ self result first
]

{ #category : #accessing }
ArangoResponse >> error [
	^ error
]

{ #category : #accessing }
ArangoResponse >> error: anObject [
	error := anObject
]

{ #category : #accessing }
ArangoResponse >> extra [
	^ extra
]

{ #category : #accessing }
ArangoResponse >> extra: anObject [
	extra := anObject
]

{ #category : #accessing }
ArangoResponse >> hasMore [
	^ hasMore
]

{ #category : #accessing }
ArangoResponse >> hasMore: anObject [
	hasMore := anObject
]

{ #category : #accessing }
ArangoResponse >> result [
	^ result
]

{ #category : #accessing }
ArangoResponse >> result: anObject [
	result := anObject
]
