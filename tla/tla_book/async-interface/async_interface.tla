-------------------------- MODULE async_interface --------------------------
EXTENDS Naturals
CONSTANT Data
VARIABLE chan

TypeInvariant == chan \in [val:Data, rdy:{0,1}, ack:{0,1}]

Init == /\ TypeInvariant
        /\ chan.ack = chan.rdy

Send(d) == /\ chan.rdy = chan.ack
           /\ chan' = [chan EXCEPT !.val = d, !.rdy = 1 - @]

Rcv == /\ chan.rdy /= chan.ack
       /\ chan' = [chan EXCEPT !.ack = 1 - @]

Next == (\exists d \in Data : Send(d)) \/ Rcv

Spec == Init /\ [][Next]_<<chan>>

=============================================================================
\* Modification History
\* Last modified Wed Jan 21 14:30:26 CET 2026 by emmanueldcosta
\* Created Wed Jan 21 14:25:28 CET 2026 by emmanueldcosta
