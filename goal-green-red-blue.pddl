(define (problem manito-goal-a)
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
      (on green red)
      (on red blue)
      (ontable blue)
    )
  )
)
