---------------------------- MODULE RateLimiter ----------------------------
EXTENDS Naturals

CONSTANT K, MaxTime
VARIABLES window, count

TypeInvariant == /\ count <= K
                 /\ window <= MaxTime
                 
Init == /\ count = 0
        /\ window = 0
        
Request == /\ count < K
           /\ count' = count + 1
           /\ window' = window

Tick == /\ window < MaxTime
        /\ count' = 0
        /\ window' = window + 1

ResetTime == /\ window = MaxTime
             /\ window' = 0
             /\ count' = count

Next == \/ Request
        \/ Tick
        \/ ResetTime

Spec == Init /\ [][Next]_<<window,count>>
    



=============================================================================
\* Modification History
\* Last modified Fri Mar 20 08:10:02 CET 2026 by emmanueldcosta
\* Created Fri Mar 20 07:25:12 CET 2026 by emmanueldcosta
