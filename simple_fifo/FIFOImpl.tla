------------------------------ MODULE FIFOImpl ------------------------------

EXTENDS Naturals, Sequences
CONSTANT Message, DEPTH
VARIABLES i_store, i_data, i_read, o_data, o_full, o_empty, fifo_data

idealFifo == INSTANCE FIFO WITH in <- i_data, q <- fifo_data, out <- o_data 

TypeInvariant ==
    /\ idealFifo!TypeInvariant
    /\ i_store \in {0, 1}
    /\ i_data \in Message
    /\ i_read \in {0, 1}
    /\ o_data \in Message
    /\ o_full \in {0, 1}
    /\ o_empty \in {0, 1}

Init ==
    /\ i_store = 0
    /\ i_data \in Message
    /\ i_read = 0
    /\ o_data = i_data
    /\ o_full = 0
    /\ o_empty = 1
    /\ fifo_data = <<>>


Store ==
    /\ o_full = 0
    /\ IF Len(fifo_data) = DEPTH-1 THEN o_full' = 1 ELSE UNCHANGED o_full
    /\ IF Len(fifo_data) = 0 THEN o_empty' = 0 ELSE UNCHANGED o_empty
    /\ idealFifo!Store

Read ==
    /\ o_empty = 0
    /\ IF Len(fifo_data) = DEPTH THEN o_full' = 0 ELSE UNCHANGED o_full
    /\ IF Len(fifo_data) = 1 THEN o_empty' = 1 ELSE UNCHANGED o_empty
    /\ idealFifo!Read
\*    /\ fifo_data # << >>
\*    /\ fifo_data' = Tail(fifo_data)
\*    /\ UNCHANGED <<i_data,o_data>>


NoDataPasses == UNCHANGED <<i_data, fifo_data, o_data, o_full, o_empty>>

Send(msg) ==
    /\ idealFifo!Send(msg)
    /\ IF i_store = 1 /\ i_read = 0 THEN Store 
       ELSE IF i_store = 0 /\ i_read = 1 THEN Read 
       ELSE UNCHANGED <<fifo_data, o_data, o_full, o_empty>>
    /\ UNCHANGED <<i_store, i_read>>

TurnOnIStore ==
    /\ i_store = 0
    /\ i_store' = 1
    /\ IF i_read = 1 THEN NoDataPasses ELSE Store
    /\ UNCHANGED <<i_read>>

TurnOffIStore ==
    /\ i_store = 1
    /\ i_store' = 0
    /\ IF i_read = 1 THEN Read ELSE NoDataPasses
    /\ UNCHANGED <<i_read>>

TurnOnIRead ==
    /\ i_read = 0
    /\ i_read' = 1
    /\ IF i_store = 1 THEN NoDataPasses ELSE Read
    /\ UNCHANGED <<i_store>>

TurnOffIRead ==
    /\ i_read = 1
    /\ i_read' = 0
    /\ IF i_store = 1 THEN Store ELSE NoDataPasses
    /\ UNCHANGED <<i_store>>

Next == \/ \exists msg \in Message: Send(msg)
        \/ TurnOnIStore
        \/ TurnOffIStore
        \/ TurnOnIRead
        \/ TurnOffIRead

Spec == Init /\ [][Next]_<<i_store, i_data, i_read, o_data, o_full, o_empty, fifo_data>>

CheckAgainstIdealSpec == idealFifo!Spec

NumberOfElements == Len(fifo_data) <= DEPTH

fullCondition ==
     o_full = 1 <=> Len(fifo_data) = DEPTH

emptyCondition ==
    o_empty = 1 <=> Len(fifo_data) = 0





=============================================================================