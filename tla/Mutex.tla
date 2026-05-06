------------------------------- MODULE Mutex -------------------------------
CONSTANTS Thread
VARIABLE ThreadState

AllMappings == [Thread -> {"Blocked","Accessing","Waiting"}]

TypeInvariant == ThreadState \in AllMappings

Init == ThreadState = [t \in Thread |-> "Blocked"]

GrantAccess(t) == /\ ThreadState[t] # "Accessing"
                  /\ \forall x \in Thread \ {t}: ThreadState[x] # "Accessing"
                  /\ ThreadState' = [ThreadState EXCEPT ![t] = "Accessing"]

RequestAccess(t) == /\ ThreadState[t] = "Blocked"
                    /\ ThreadState' = [ThreadState EXCEPT ![t] = "Waiting"]

BlockAccess(t) == /\ ThreadState[t] = "Accessing"
                  /\ ThreadState' = [ThreadState EXCEPT ![t] = "Blocked"]

Next == \/ \E t \in Thread: GrantAccess(t) \/ BlockAccess(t) \/ RequestAccess(t)

Spec == Init /\ [][Next]_ThreadState

=============================================================================
\* Modification History
\* Last modified Wed Mar 25 08:46:42 CET 2026 by emmanueldcosta
\* Created Wed Mar 25 08:14:37 CET 2026 by emmanueldcosta
