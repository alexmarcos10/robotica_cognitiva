(define (domain soccer)
  (:predicates
    (ball-at ?player)
    (player ?p)
  )
  
  (:action pass-ball
    :parameters (?from ?to)
    :precondition (and (ball-at ?from) (player ?from) (player ?to))
    :effect (and (not (ball-at ?from)) (ball-at ?to))
  )
)


; Dominio del problema. 
; 1)Tenemos los predicados que definen el estado inicial y final del problema, player indica que un jugador esta en el campo y 
; ball-at indica que el balon esta en posesion de un jugador
; 2)Definimos las acciones que se pueden realizar en el problema, pasar el balon de un jugador a otro.
; 3) La accion pass-ball tiene como parametros ?from y ?to que representan el jugador que pasa el balon y el jugador que recibe el balon
; 4) La accion pass-ball tiene como precondicion que el balon este en posesion del jugador que pasa el balon y que ambos jugadores esten en el campo
; 5) La accion pass-ball tiene como efecto que el jugador que pasa el balon ya no tenga el balon y que el jugador que recibe el balon tenga el balon