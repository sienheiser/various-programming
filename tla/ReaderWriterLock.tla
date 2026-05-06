-------------------------- MODULE ReaderWriterLock --------------------------
CONSTANT Entity
VARIABLE EntityState

AllMappings == [Entity -> {"Read","Write","Wait"}]

TypeInvariant == EntityState \in AllMappings

Init == EntityState = [e \in Entity |-> "Wait"]

MakeEntityWait(e) == /\ EntityState[e] # "Wait"
                     /\ EntityState' = [EntityState EXCEPT ![e] = "Wait"]

GrantWriteAccess(e) == /\ EntityState[e] # "Write"
                       /\ \forall x \in Entity \ {e}: EntityState[x] = "Wait"
                       /\ EntityState' = [EntityState EXCEPT ![e] = "Write"]
                      
GrantReadAccess(e) == /\ EntityState[e] # "Read"
                      /\ ~(\E x \in Entity \ {e}: EntityState[x] = "Write")
                      /\ EntityState' = [EntityState EXCEPT ![e] = "Read"]

Next == \/ \E e \in Entity: MakeEntityWait(e) \/ GrantWriteAccess(e) \/ GrantReadAccess(e)

Spec == Init /\ [][Next]_EntityState


=============================================================================
\* Modification History
\* Last modified Wed Mar 25 09:43:04 CET 2026 by emmanueldcosta
\* Created Wed Mar 25 08:59:01 CET 2026 by emmanueldcosta
