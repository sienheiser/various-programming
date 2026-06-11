------------------------------ MODULE ChannelImpl ------------------------------
EXTENDS Naturals
CONSTANT Data
VARIABLES chan, i_wr_data, i_wr_en, i_rd_en, o_rd_data

Mapping == INSTANCE Channel WITH Data <- Data, chan <- chan

TypeInvariant == 
    /\ Mapping!TypeInvariant
    /\ i_wr_data \in Data
    /\ o_rd_data \in Data
    /\ i_wr_en \in {0,1}
    /\ i_rd_en \in {0,1}


Init == 
    /\ i_wr_data \in Data
    /\ chan = [val |-> i_wr_data, rdy |-> 1, ack |-> 1]
    /\ o_rd_data = i_wr_data
    /\ i_wr_en = 0
    /\ i_rd_en = 0
    
Send(d) ==
    /\ i_wr_data' = d
    /\ Mapping!Send(d)
    /\ UNCHANGED o_rd_data

Receive ==
    /\ Mapping!Receive
    /\ o_rd_data' = chan.val
    /\ UNCHANGED i_wr_data

NoChannelChanged == UNCHANGED <<chan, i_wr_data, o_rd_data>>

TurnOnWrEn(d) ==
    /\ i_wr_en = 0
    /\ i_wr_en' = 1
    /\ IF i_rd_en = 1
       THEN NoChannelChanged
       ELSE Send(d)
    /\ UNCHANGED i_rd_en        

TurnOffWrEn ==
    /\ i_wr_en = 1
    /\ i_wr_en' = 0
    /\ IF i_rd_en = 1
       THEN Receive
       ELSE NoChannelChanged
    /\ UNCHANGED i_rd_en 


TurnOnRdEn ==
    /\ i_rd_en = 0
    /\ i_rd_en' = 1
    /\ IF i_wr_en = 1 
       THEN NoChannelChanged
       ELSE Receive
    /\ UNCHANGED i_wr_en

TurnOffRdEn(d) ==
    /\ i_rd_en = 1
    /\ i_rd_en' = 0
    /\ IF i_wr_en = 1
       THEN Send(d)
       ELSE NoChannelChanged
    /\ UNCHANGED i_wr_en

Refinement == Mapping!Spec

Next == \/ (\exists d \in Data: TurnOnWrEn(d) \/ TurnOffRdEn(d))
        \/ TurnOffWrEn
        \/ TurnOnRdEn

Spec == Init /\ [][Next]_<<chan,i_wr_data,o_rd_data,i_wr_en,i_rd_en>>



=============================================================================