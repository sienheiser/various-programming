----------------------------- MODULE IdemPotent -----------------------------
EXTENDS Sequences, Naturals
CONSTANT Keys
VARIABLES serverState

TypeInvariant == /\ serverState \in Seq(Keys)
                 /\ Keys # {}

AtMostOnce ==
  \A r \in Keys:
    Len(SelectSeq(serverState, LAMBDA x: x = r)) <= 1

NoDuplicates ==
  \A i, j \in 1..Len(serverState):
    i # j => serverState[i] # serverState[j]


Init == serverState = << >>

MakeRequest(r) == IF r \in serverState
                  THEN serverState' = serverState
                  ELSE serverState' = Append(serverState,r)

Next == \E r \in Keys: MakeRequest(r)

Spec == Init /\ [][Next]_serverState

THEOREM Spec => []NoDuplicates
=============================================================================
\* Modification History
\* Last modified Tue Mar 31 15:18:15 CEST 2026 by emmanueldcosta
\* Created Tue Mar 31 14:07:12 CEST 2026 by emmanueldcosta
