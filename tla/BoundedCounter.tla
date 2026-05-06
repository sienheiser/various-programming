--------------------------- MODULE BoundedCounter ---------------------------
EXTENDS Naturals
CONSTANT N
ASSUME N \in Nat \ {0}

VARIABLE counter

TypeInvariant == counter \in (0..N-1)

Init == counter \in (0..N-1)

Increment == /\ counter < N - 1
             /\ counter' = counter + 1

Decrement == /\ counter > 0
             /\ counter' = counter - 1

Next == \/ Increment
        \/ Decrement
        \/ UNCHANGED counter

Spec == Init /\ [][Next]_counter


=============================================================================
\* Modification History
\* Last modified Wed Mar 18 13:03:19 CET 2026 by emmanueldcosta
\* Created Wed Mar 18 12:47:18 CET 2026 by emmanueldcosta
