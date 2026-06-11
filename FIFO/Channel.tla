------------------------------ MODULE Channel ------------------------------
EXTENDS Naturals
CONSTANT Data
VARIABLE chan

TypeInvariant == chan \in [val:Data, rdy:{0,1}, ack:{0,1}]

Init == /\ TypeInvariant
        /\ chan.rdy = chan.ack

Send(d) == /\ chan.rdy = chan.ack
           /\ chan' = [chan EXCEPT !.val = d, !.rdy = 1 - @]
                
Receive == /\ chan.rdy /= chan.ack
           /\ chan' = [chan EXCEPT !.ack = 1 - chan.ack]
                
Next == \/ (\exists d \in Data: Send(d))
        \/ Receive

Spec == Init /\ [][Next]_chan
=============================================================================
\* Modification History
\* Last modified Mon May 18 12:27:14 CEST 2026 by emmanueldcosta
\* Created Wed Jan 21 14:49:54 CET 2026 by emmanueldcosta
