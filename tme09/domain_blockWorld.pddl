(define (domain blockWorld)
    (:requirements :strips :typing)
    (:types block)
    (:predicates
        (on ?x - block ?y - block)
        (ontable ?x - block)
        (clear ?x - block)
        (handempty)
        (holding ?x - block))
    (:action pick-up
        ;;; action qui ramasse un bloc pose sur la table
        :parameters (?x - block)
        :precondition (and (clear ?x) (ontable ?x) (handempty))
        :effect (and (not (ontable ?x))
                (not (clear ?x))
                (not (handempty))
                (holding ?x)))
    (:action unstack
        ;;; action qui désempiler un bloc pose sur un autre bloc
        :parameters (?x - block ?y - block)
        :precondition (and (clear ?x) (on ?x ?y) (handempty))
        :effect (and (not (on ?x ?y))
                (not (clear ?x))
                (not (handempty))
                (holding ?x)
                (clear ?y)))
    (:action putdown
        ;;; action qui ramasse un bloc pose sur la table
        :parameters (?x - block)
        :precondition (holding ?x)
        :effect (and (not (holding ?x))
                (clear ?x)
                (ontable ?x)
                (handempty)))
    (:action stack
        ;;; action qui empiler un bloc sur un autre bloc
        :parameters (?x - block ?y - block)
        :precondition (and (clear ?y) (holding ?x))
        :effect (and (on ?x ?y)
                (clear ?x)
                (handempty)
                (not(holding ?x))
                (not(clear ?y))))
                   
)
