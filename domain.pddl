(define (domain manito-bloques)
  (:requirements :strips :typing)
  (:types bloque)
  
  (:predicates
    (sobre_mesa ?b - bloque)
    (sobre ?x ?y - bloque)
    (libre ?b - bloque)
    (sosteniendo ?b - bloque)
    (mano_vacia)
  )
  
  (:action tomar
    :parameters (?x - bloque)
    :precondition (and (libre ?x) (sobre_mesa ?x) (mano_vacia))
    :effect (and (sosteniendo ?x) (not (mano_vacia)) (not (sobre_mesa ?x)) (not (libre ?x)))
  )
  
  (:action soltar
    :parameters (?x - bloque)
    :precondition (sosteniendo ?x)
    :effect (and (sobre_mesa ?x) (mano_vacia) (not (sosteniendo ?x)) (libre ?x))
  )
  
  (:action apilar
    :parameters (?x ?y - bloque)
    :precondition (and (sosteniendo ?x) (libre ?y))
    :effect (and (sobre ?x ?y) (libre ?x) (not (sosteniendo ?x)) (mano_vacia) (not (libre ?y)))
  )
  
  (:action desapilar
    :parameters (?x ?y - bloque)
    :precondition (and (sobre ?x ?y) (libre ?x) (mano_vacia))
    :effect (and (sosteniendo ?x) (libre ?y) (not (sobre ?x ?y)) (not (libre ?x)) (not (mano_vacia)))
  )
)