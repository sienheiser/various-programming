------------------------------ MODULE Channel ------------------------------

EXTENDS Naturals, Json
CONSTANT Data
VARIABLE chan

TypeInvariant == chan \in [val:Data, rdy:{0,1}, ack:{0,1}]

Init == /\ TypeInvariant
        /\ chan.rdy = chan.ack

Send(d) == /\ chan.rdy = chan.ack
           /\ LET nextChan == [chan EXCEPT !.val = d, !.rdy = 1 - @] IN
                /\ chan' = nextChan
                /\ ndJsonSerialize("/home/emmanueldcosta/Workspace/Other/various-programming/tla/tla_book/FIFO/channel_trace.jsonl", <<[action |-> "send", val |-> d, state |-> nextChan]>>)

Recieve == /\ chan.rdy /= chan.ack
           /\ LET nextChan == [chan EXCEPT !.ack = 1 - chan.ack] IN
                /\ chan' = nextChan
                /\ ndJsonSerialize("/home/emmanueldcosta/Workspace/Other/various-programming/tla/tla_book/FIFO/channel_trace.jsonl", <<[action |-> "receive", state |-> nextChan]>>)

Next == \/ (\exists d \in Data: Send(d))
        \/ Recieve

Spec == Init /\ [][Next]_chan
=============================================================================
\* Modification History
\* Last modified Tue May 05 12:53:49 CEST 2026 by emmanueldcosta
\* Created Wed Jan 21 14:49:54 CET 2026 by emmanueldcosta
