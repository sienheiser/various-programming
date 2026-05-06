-------------------------------- MODULE FIFO --------------------------------
EXTENDS Naturals, Sequences
CONSTANT Message
VARIABLES in, out, q

InChan == INSTANCE Channel WITH Data <- Message, chan <- in
OutChan == INSTANCE Channel WITH Data <- Message, chan <- out

TypeInvariant == /\ InChan!TypeInvariant
                 /\ OutChan!TypeInvariant
                 /\ q \in Seq(Message)

Init == /\ InChan!Init
        /\ OutChan!Init
        /\ q = <<>>
        
SSend(msg) == /\ InChan!Send(msg)
              /\ UNCHANGED <<out,q>>

BRcv == /\ InChan!Recieve
        /\ q' = Append(q,in.val)
        /\ UNCHANGED out

BSend == /\ q /= <<>>
         /\ OutChan!Send(Head(q))
         /\ q' = Tail(q)
         /\ UNCHANGED in

RRcv == /\ OutChan!Recieve
        /\ UNCHANGED <<in,q>>

Next == \/ (\exists msg \in Message : SSend(msg))
        \/ BRcv
        \/ BSend
        \/ RRcv

Spec == Init /\ [][Next]_<<in,out,q>>

THEOREM Spec => []TypeInvariant
=============================================================================
\* Modification History
\* Last modified Wed Jan 21 15:39:28 CET 2026 by emmanueldcosta
\* Created Wed Jan 21 15:02:00 CET 2026 by emmanueldcosta
