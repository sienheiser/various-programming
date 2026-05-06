------------------------ MODULE simp_async_interface ------------------------
EXTENDS Naturals
CONSTANTS Data
VARIABLES val, rdy, ack

TypeInvariant == /\ val \in Data 
                 /\ rdy \in {0,1} 
                 /\ ack \in {0,1}
                 
Init == /\ val \in Data
        /\ rdy \in {0,1}
        /\ ack = rdy

Send == /\ ack = rdy
        /\ val' \in Data
        /\ rdy' = 1 - rdy
        /\ UNCHANGED ack

Recieve == /\ ack /= rdy
           /\ UNCHANGED val
           /\ UNCHANGED rdy
           /\ ack' = 1 - ack

Next == \/ Send
        \/ Recieve

Spec == Init /\ [][Next]_<<val,rdy,ack>>

=============================================================================
\* Modification History
\* Last modified Wed Jan 21 14:20:54 CET 2026 by emmanueldcosta
\* Created Wed Jan 21 13:52:35 CET 2026 by emmanueldcosta
