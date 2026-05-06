--------------------------- MODULE CachedBackend ---------------------------
CONSTANTS Keys, Values
VARIABLES backend, cache

SetOfMaps == [Keys -> Values]

TypeInvariant == /\ backend \in SetOfMaps
                 /\ backend \in SetOfMaps
                 
Init == /\ backend \in SetOfMaps
        /\ cache = backend

Write(k,v) == /\ backend' = [backend EXCEPT ![k] = v]
              /\ UNCHANGED cache

RefreshCache(k) == /\ cache' = [cache EXCEPT ![k] = backend[k]]
                   /\ UNCHANGED backend

Next == \/ \E k \in Keys, v \in Values: Write(k,v)
        \/ \E k \in Keys: RefreshCache(k)
        
Spec == Init /\ [][Next]_<<backend,cache>>

=============================================================================
\* Modification History
\* Last modified Fri Mar 20 08:55:49 CET 2026 by emmanueldcosta
\* Created Fri Mar 20 08:28:06 CET 2026 by emmanueldcosta
