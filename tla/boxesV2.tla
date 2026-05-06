------------------------------ MODULE boxesV2 ------------------------------
CONSTANT items
VARIABLES array, box

TypeInvariant ==
  /\ array \subseteq items
  /\ box \subseteq items

Init ==
  /\ array = {}
  /\ box = {}

\* Internal state update (triggered by GUI intent)
AddItemArray(i) ==
  /\ i \in items
  /\ i \notin array
  /\ array' = array \cup {i}
  /\ UNCHANGED box

RemoveItemArray(i) ==
  /\ i \in array
  /\ array' = array \ {i}
  /\ UNCHANGED box

\* GUI synchronization actions
AddItemBox(i) ==
  /\ i \in array
  /\ i \notin box
  /\ box' = box \cup {i}
  /\ UNCHANGED array

RemoveItemBox(i) ==
  /\ i \notin array
  /\ i \in box
  /\ box' = box \ {i}
  /\ UNCHANGED array

Next ==
  \/ \E i \in items: AddItemArray(i)
  \/ \E i \in items: RemoveItemArray(i)
  \/ \E i \in items: AddItemBox(i)
  \/ \E i \in items: RemoveItemBox(i)
=============================================================================
\* Modification History
\* Last modified Wed Mar 18 08:31:40 CET 2026 by emmanueldcosta
\* Created Wed Mar 18 07:54:21 CET 2026 by emmanueldcosta
