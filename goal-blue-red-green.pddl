(define (problem manito-goal-b)
  (:domain manito-blocks)
  (:objects blue red green - block)
  
  (:init
    (ontable blue)
    (ontable red)
    (ontable green)
    (clear blue)
    (clear red)
    (clear green)
    (handempty)
  )
  
  (:goal
    (and
      (on blue red)
      (on red green)
      (ontable green)
    )
  )
)
