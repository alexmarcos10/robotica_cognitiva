(define (problem pass-the-ball)
  (:domain soccer)
  
  (:objects
    player1 player2 player3
  )
  
  (:init
    (player player1)
    (player player2)
    (player player3)
    (ball-at player3)
  )
  
  (:goal
    (ball-at player2)
  )
)


; Se define un problema especifico utilizando el dominio soccer
; Se establecen 3 objetos: player1, player2 y player3 
; Se establece que los 3 objetos son jugadores y que el balon esta en player3
; Se establece que el objetivo es que el balon este en player2
