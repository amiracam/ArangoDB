Class {
	#name : #ArangoCollectionNotFoundError,
	#superclass : #ArangoAPIError,
	#category : #'Arango-Core-Exceptions'
}

{ #category : #'as yet unclassified' }
ArangoCollectionNotFoundError class >> errorNumber [
	^ 1203
]
