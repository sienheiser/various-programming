------------------------------ MODULE boxesV1 ------------------------------
CONSTANT items
VARIABLES box1, box2

TypeInvariant == /\ box1 \subseteq items
                 /\ box2 \subseteq items

Init == /\ box1 = items
        /\ box2 = {}

AddItem(i) == /\ box2' = box2 \cup {i}
              /\ UNCHANGED box1
              
RemoveItem(i) == /\ i \in box2
                 /\ box2' = box2 \ {i}
                 /\ UNCHANGED box1

Next == \/ \E i \in items: AddItem(i)
        \/ \E i \in items: RemoveItem(i)


=============================================================================
\* Modification History
\* Last modified Wed Mar 18 07:51:23 CET 2026 by emmanueldcosta
\* Created Tue Mar 17 15:08:32 CET 2026 by emmanueldcosta
