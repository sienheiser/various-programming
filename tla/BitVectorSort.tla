--------------------------- MODULE BitVectorSort ---------------------------
EXTENDS Naturals, Sequences
CONSTANTS N, Input
VARIABLES bitVector

Values == 0..N+1
TypeInvariant == bitVector \in [Values -> {0,1}]

Init == bitVector = [x \in Values |-> 0]

TurnOnBit(x) == /\ bitVector[x] = 0
                /\ bitVector' = [bitVector EXCEPT ![x] = 1]

Next == \/ \E x \in Input: TurnOnBit(x)

Spec == Init /\ [][Next]_bitVector

=============================================================================
\* Modification History
\* Last modified Mon Apr 27 09:23:04 CEST 2026 by emmanueldcosta
\* Created Mon Apr 27 08:56:39 CEST 2026 by emmanueldcosta
