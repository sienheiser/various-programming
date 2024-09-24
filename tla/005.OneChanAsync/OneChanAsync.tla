---------------------------- MODULE OneChanAsync ----------------------------
EXTENDS Naturals

CONSTANT Data \* Set contaning data that will be send to reciever

VARIABLES val,rdy,ack

TypeInvariant == /\ val \in Data 
                 /\ rdy \in {0,1}
                 /\ ack \in {0,1}

Init == /\ val \in Data
        /\ rdy \in {0,1}
        /\ ack = rdy

Send == /\ rdy = ack
        /\ rdy' = 1 - rdy
        /\ val' \in Data
        /\ UNCHANGED ack

Receive == /\ rdy # ack
           /\ ack' = 1 - ack
           /\ UNCHANGED <<rdy,val>>

Next == \/ Send
        \/ Receive
        
Spec == Init /\ [][Next]_<<val,rdy,ack>>
=============================================================================
\* Modification History
\* Last modified Tue Sep 24 08:38:40 CEST 2024 by emmanueldcosta
\* Created Tue Sep 24 08:24:59 CEST 2024 by emmanueldcosta
