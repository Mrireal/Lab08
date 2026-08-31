(define (problem meta-a-verde-rojo-azul)
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
      (sobre verde rojo)
      (sobre rojo azul)
      (sobre_mesa azul)
    )
  )
)
