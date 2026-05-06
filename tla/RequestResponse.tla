-------------------------- MODULE RequestResponse --------------------------
EXTENDS Sequences, Naturals

CONSTANTS Requests, MaxQueue

VARIABLES queue, state

TypeInvariant == /\ queue \in Seq(Requests)
                 /\ state \in {"Idle","Processing"}

AddRequest(r) == /\ Len(queue) < MaxQueue
                 /\ queue' = Append(queue, r)
                 /\ UNCHANGED state

Init == /\ queue = << >>
        /\ state = "Idle"

Process == /\ queue # << >>
           /\ state = "Idle"
           /\ queue' = Tail(queue)
           /\ state' = "Processing"

CompleteProcessing == /\ state = "Processing"
                      /\ state' = "Idle"
                      /\ UNCHANGED queue

Next == \/ \E r \in Requests: AddRequest(r)
        \/ Process
        \/ CompleteProcessing

Spec == Init /\ [][Next]_<<queue,state>>

THEOREM Spec => []TypeInvariant

=============================================================================
\* Modification History
\* Last modified Thu Mar 19 15:33:36 CET 2026 by emmanueldcosta
\* Created Thu Mar 19 10:21:57 CET 2026 by emmanueldcosta
