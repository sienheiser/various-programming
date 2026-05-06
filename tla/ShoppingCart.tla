---------------------------- MODULE ShoppingCart ----------------------------
CONSTANT Catalog
ASSUME Catalog # {}

VARIABLE Cart

TypeInvariant == Cart \subseteq Catalog
Init == Cart = {}

AddItem(i) == Cart' = Cart \cup {i}

RemoveItem(i) == /\ i \in Cart
                 /\ Cart' = Cart \ {i}

Next == \/ \E i \in Catalog: AddItem(i)
        \/ \E i \in Catalog: RemoveItem(i)
        \/ UNCHANGED Cart

Spec == Init /\ [][Next]_Cart

=============================================================================
\* Modification History
\* Last modified Wed Mar 18 13:22:54 CET 2026 by emmanueldcosta
\* Created Wed Mar 18 13:15:13 CET 2026 by emmanueldcosta
