-------------------------------- MODULE FIFO --------------------------------
EXTENDS Naturals, Sequences
CONSTANT Message
VARIABLES in, q, out

TypeInvariant ==
    /\ in \in Message
    /\ q \in Seq(Message)
    /\ out \in Message

Init ==
    /\ in \in Message
    /\ out \in Message
    /\ q = <<>>

Send(msg) ==
    /\ in' = msg
    /\ UNCHANGED <<q, out>>

Store ==
    /\ q' = Append(q, in)
    /\ UNCHANGED <<in, out>>

Read ==
    /\ q # << >>
    /\ out' = Head(q)
    /\ q' = Tail(q)
    /\ UNCHANGED in

Next == 
    \/ \exists msg \in Message: Send(msg)
    \/ Store
    \/ Read

Spec == 
    /\ Init /\ [][Next]_<<in, q, out>>
=============================================================================
\* Modification History
\* Last modified Mon May 25 11:25:06 CEST 2026 by emmanueldcosta
\* Created Thu May 21 12:02:28 CEST 2026 by emmanueldcosta
