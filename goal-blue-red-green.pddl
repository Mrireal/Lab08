(define (problem meta-b-azul-rojo-verde)
  (:domain manito-bloques)
  (:objects azul rojo verde - bloque)
  
  (:init
    (sobre_mesa azul)
    (sobre_mesa rojo)
    (sobre_mesa verde)
    (libre azul)
    (libre rojo)
    (libre verde)
    (mano_vacia)
  )
  
  (:goal
    (and
      (sobre azul rojo)
      (sobre rojo verde)
      (sobre_mesa verde)
    )
  )
)
