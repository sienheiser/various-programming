-------------------------------- MODULE FIFOImplV2 --------------------------------
EXTENDS Naturals, Sequences
CONSTANT Message, BUFFER_WIDTH
ASSUME  BUFFER_WIDTH \in Nat

VARIABLES i_wr_en, i_wr_q_en, i_data, i_rd_en, i_rd_q_en, o_data, o_full, o_empty, in, q, out, interface_1, interface_2

IdealFIFO == INSTANCE FIFO WITH Message <- Message, in <- in, out <- out, q <- q
IdealInChan == INSTANCE Channel WITH Data <- Message, chan <- in
IdealOutChan == INSTANCE Channel WITH Data <- Message, chan <- out 

InChan ==  INSTANCE ChannelImpl WITH Data <- Message, chan <- in,  i_wr_en <- i_wr_en, i_rd_en <- i_wr_q_en, i_wr_data <- i_data, o_rd_data <- interface_1
OutChan == INSTANCE ChannelImpl WITH Data <- Message, chan <- out, i_wr_en <- i_rd_q_en, i_rd_en <- i_rd_en, i_wr_data <- interface_2, o_rd_data <- o_data

Refinement == IdealInChan!Spec /\ IdealOutChan!Spec /\ IdealFIFO!Spec /\ InChan!Spec

TypeInvariant ==
    /\ i_wr_en \in {0,1}
    /\ i_wr_q_en \in {0,1}
    /\ i_data \in Message
    /\ i_rd_en \in {0,1}
    /\ i_rd_q_en \in {0,1}
    /\ o_data \in Message
    /\ o_full \in {0,1}
    /\ o_empty \in {0,1}
    /\ in \in [val: Message, rdy: {0,1}, ack: {0,1}]
    /\ q \in Seq(Message)
    /\ out \in [val: Message, rdy: {0,1}, ack: {0,1}]
    /\ interface_1 \in Message
    /\ interface_2 \in Message

Init == 
    /\ i_wr_en = 0
    /\ i_wr_q_en = 0
    /\ i_data \in Message
    /\ i_rd_en = 0
    /\ i_rd_q_en = 0
    /\ o_data = i_data
    /\ o_full = 0
    /\ o_empty = 1
    /\ in = [val |-> i_data, rdy |-> 1, ack |-> 1]
    /\ q = <<>>
    /\ out = in
    /\ interface_1 = i_data
    /\ interface_2 = i_data

SSend(msg) == 
    /\ InChan!Send(msg)
    /\ UNCHANGED <<o_data, o_full, o_empty, q, out, interface_1, interface_2>>

BRcv ==
    /\ IF Len(q) = BUFFER_WIDTH - 1 THEN o_full = 1 ELSE UNCHANGED o_full
    /\ IF Len(q) = 1 THEN o_empty' = 0 ELSE UNCHANGED o_empty
    /\ IF Len(q) < BUFFER_WIDTH 
       THEN /\ InChan!Receive
            /\ q' = Append(q, in.val)
       ELSE UNCHANGED <<in, interface_1, q>>
    /\ UNCHANGED <<i_data, o_data, out, interface_2>>
    

BSend ==
    /\ IF Len(q) = BUFFER_WIDTH THEN o_full = 0 ELSE UNCHANGED o_full
    /\ IF Len(q) = 1 THEN o_empty' = 1 ELSE UNCHANGED o_empty
    /\ IF 0 < Len(q)  /\ Len(q) < BUFFER_WIDTH 
       THEN /\ OutChan!Send(Head(q))
            /\ q' = Tail(q)
        ELSE UNCHANGED <<interface_2, out, q>>
    /\ UNCHANGED <<i_data, o_data, in, interface_1>>


RRcv ==
    /\ OutChan!Receive
    /\ UNCHANGED <<i_data, o_full, o_empty, in, q, interface_1, interface_2>>

NoDataPasses == UNCHANGED <<i_data, o_data, o_full, o_empty, in, q, out, interface_1, interface_2>>

\* TurnOnWrEn(msg) ==
\*     /\ i_wr_en = 0
\*     /\ i_wr_en' = 1
\*     /\ IF i_wr_q_en = 1 \/ i_rd_en = 1 \/ i_rd_q_en = 1 THEN NoDataPasses ELSE SSend(msg)
\*     /\ UNCHANGED <<i_wr_q_en, i_rd_en, i_rd_q_en>>
    
\* TurnOffWrEn ==
\*     /\ i_wr_en = 1
\*     /\ i_wr_en' = 0
\*     /\ IF i_wr_q_en = 1 /\ i_rd_en = 0 /\ i_rd_q_en = 0 THEN BRcv 
\*        ELSE IF i_wr_q_en = 0 /\ i_rd_en = 0 /\ i_rd_q_en = 1 THEN BSend 
\*        ELSE IF i_wr_q_en = 0 /\ i_rd_en = 1 /\ i_rd_q_en = 0 THEN RRcv 
\*        ELSE NoDataPasses 
\*     /\ UNCHANGED <<i_wr_q_en, i_rd_en, i_rd_q_en>>

\* TurnOnWrQEn ==
\*     /\ i_wr_q_en = 0
\*     /\ i_wr_q_en' = 1
\*     /\ IF i_wr_en = 1 \/ i_rd_en = 1 \/ i_rd_q_en = 1 THEN NoDataPasses ELSE BRcv
\*     /\ UNCHANGED <<i_wr_en, i_rd_en, i_rd_q_en>>

\* TurnOffWrQEn(msg) ==
\*     /\ i_wr_q_en = 1
\*     /\ i_wr_q_en' = 0
\*     /\ IF i_wr_en = 1 /\ i_rd_en = 0 /\ i_rd_q_en = 0 THEN SSend(msg) 
\*        ELSE IF i_wr_en = 0 /\ i_rd_en = 0 /\ i_rd_q_en = 1 THEN BSend
\*        ELSE IF i_wr_en = 0 /\ i_rd_en = 1 /\ i_rd_q_en = 0 THEN RRcv
\*        ELSE NoDataPasses
\*     /\ UNCHANGED <<i_wr_en, i_rd_en, i_rd_q_en>>

\* TurnOnRdQEn ==
\*     /\ i_rd_q_en = 0
\*     /\ i_rd_q_en' = 1
\*     /\ IF i_wr_en = 1 \/ i_wr_q_en = 1 \/ i_rd_en = 1 THEN NoDataPasses ELSE BSend
\*     /\ UNCHANGED <<i_wr_en, i_wr_q_en, i_rd_en>>

\* TurnOffRdQEn(msg) ==
\*     /\ i_rd_q_en = 1
\*     /\ i_rd_q_en' = 0
\*     /\ IF i_wr_en = 1 /\ i_wr_q_en = 0 /\ i_rd_en = 0 THEN SSend(msg)
\*        ELSE IF i_wr_en = 0 /\ i_wr_q_en = 1 /\ i_rd_en = 0 THEN BRcv
\*        ELSE IF i_wr_en = 0 /\ i_wr_q_en = 0 /\ i_rd_en = 1 THEN RRcv 
\*        ELSE NoDataPasses
\*     /\ UNCHANGED <<i_wr_en, i_wr_q_en, i_rd_en>>

\* TurnOnRdEn ==
\*     /\ i_rd_en = 0
\*     /\ i_rd_en' = 1
\*     /\ IF i_wr_en = 1 \/ i_wr_q_en = 1 \/ i_rd_q_en = 1 THEN NoDataPasses ELSE RRcv
\*     /\ UNCHANGED <<i_wr_en, i_wr_q_en, i_rd_q_en>>

\* TurnOffRdEn(msg) ==
\*     /\ i_rd_en = 1
\*     /\ i_rd_en' = 0
\*     /\ IF i_wr_en = 1 /\ i_wr_q_en = 0 /\ i_rd_q_en = 0 THEN SSend(msg)
\*        ELSE IF i_wr_en = 0 /\ i_wr_q_en = 1 /\ i_rd_q_en = 0 THEN BRcv 
\*        ELSE IF i_wr_en = 0 /\ i_wr_q_en = 0 /\ i_rd_q_en = 1 THEN BSend
\*        ELSE NoDataPasses
\*     /\ UNCHANGED <<i_wr_en, i_wr_q_en, i_rd_q_en>>

TurnOnWrEn(msg) ==
    /\ i_wr_en = 0
    /\ i_wr_en' = 1
    /\ IF i_wr_q_en = 1 THEN NoDataPasses ELSE SSend(msg)
    /\ UNCHANGED <<i_wr_q_en, i_rd_en, i_rd_q_en>>

TurnOffWrEn ==
    /\ i_wr_en = 1
    /\ i_wr_en' = 0
    /\ IF i_wr_q_en = 1 THEN BRcv ELSE NoDataPasses 
    /\ UNCHANGED <<i_wr_q_en, i_rd_en, i_rd_q_en>>

TurnOnWrQEn ==
    /\ i_wr_q_en = 0
    /\ i_wr_q_en' = 1
    /\ IF i_wr_en = 1 THEN NoDataPasses ELSE BRcv
    /\ UNCHANGED <<i_wr_en, i_rd_en, i_rd_q_en>>

TurnOffWrQEn(msg) ==
    /\ i_wr_q_en = 1
    /\ i_wr_q_en' = 0
    /\ IF i_wr_en = 1 THEN SSend(msg) ELSE NoDataPasses
    /\ UNCHANGED <<i_wr_en, i_rd_en, i_rd_q_en>>

TurnOnRdQEn ==
    /\ i_rd_q_en = 0
    /\ i_rd_q_en' = 1
    /\ IF i_rd_en = 1 THEN NoDataPasses ELSE BSend
    /\ UNCHANGED <<i_wr_en, i_wr_q_en, i_rd_en>>

TurnOffRdQEn(msg) ==
    /\ i_rd_q_en = 1
    /\ i_rd_q_en' = 0
    /\ IF i_rd_en = 1 THEN RRcv ELSE NoDataPasses
    /\ UNCHANGED <<i_wr_en, i_wr_q_en, i_rd_en>>

TurnOnRdEn ==
    /\ i_rd_en = 0
    /\ i_rd_en' = 1
    /\ IF i_rd_q_en = 1 THEN NoDataPasses ELSE RRcv
    /\ UNCHANGED <<i_wr_en, i_wr_q_en, i_rd_q_en>>

TurnOffRdEn(msg) ==
    /\ i_rd_en = 1
    /\ i_rd_en' = 0
    /\ IF i_rd_q_en = 1 THEN BSend ELSE NoDataPasses
    /\ UNCHANGED <<i_wr_en, i_wr_q_en, i_rd_q_en>>
    
Next == \/ \E msg \in Message: TurnOnWrEn(msg) \/ TurnOffWrQEn(msg) \/ TurnOffRdQEn(msg) \/ TurnOffRdEn(msg)
        \/ TurnOffWrEn
        \/ TurnOnWrQEn
        \/ TurnOnRdQEn
        \/ TurnOnRdEn

Spec == Init /\ [][Next]_<<i_wr_en, i_wr_q_en, i_data, i_rd_en, i_rd_q_en, o_data, o_full, o_empty, in, q, out, interface_1, interface_2>>
=============================================================================