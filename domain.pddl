(define (domain manito-blocks)
  (:requirements :strips :typing)
  (:types block)
  
  (:predicates
    (ontable ?b - block)
    (on ?x ?y - block)
    (clear ?b - block)
    (holding ?b - block)
    (handempty)
  )
  
  (:action pickup
    :parameters (?x - block)
    :precondition (and (clear ?x) (ontable ?x) (handempty))
    :effect (and (holding ?x) (not (handempty)) (not (ontable ?x)) (not (clear ?x)))
  )
  
  (:action putdown
    :parameters (?x - block)
    :precondition (holding ?x)
    :effect (and (ontable ?x) (handempty) (not (holding ?x)) (clear ?x))
  )
  
  (:action stack
    :parameters (?x ?y - block)
    :precondition (and (holding ?x) (clear ?y))
    :effect (and (on ?x ?y) (clear ?x) (not (holding ?x)) (handempty) (not (clear ?y)))
  )
  
  (:action unstack
    :parameters (?x ?y - block)
    :precondition (and (on ?x ?y) (clear ?x) (handempty))
    :effect (and (holding ?x) (clear ?y) (not (on ?x ?y)) (not (clear ?x)) (not (handempty)))
  )
)