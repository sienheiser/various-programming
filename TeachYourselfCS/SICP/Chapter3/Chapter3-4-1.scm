;exerice 3.38
;Peter: (set! balance (+ balance 10))
;Paul: (set! balance (- balance 20))
;Mary: (set! balance (- balance (/ balance 2)))
;a. List all the different possible values for balance aer
;these three transactions have been completed, assuming that the banking system forces the three processes
;to run sequentially in some order.

;Suppose the account contains x amount of money
;1. ((x+10)-20)-((x+10)-20)/2 = ((x+10)-20)/2 = x/2 -5
;2. ((x+10)-(x+10)/2)-20 = (x+10)/2 -20 = x/2 - 15
;3. ((x-20)+10)-((x-20)+10)/2 = ((x-20)+10)/2 = x/2 - 5
;4. ((x-20)-(x-20)/2)+10 = (x-20)/2 + 10 = x/2
;5. (x-x/2)+10-20 = x/2-10
;6. (x-x/2)-20+10 = x/2-10