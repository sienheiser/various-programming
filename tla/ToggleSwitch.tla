---------------------------- MODULE ToggleSwitch ----------------------------
VARIABLE toggle

TypeInvariant == toggle \in BOOLEAN

Init == toggle = FALSE

Switch == toggle' = ~toggle 

Next == Switch \/ UNCHANGED toggle

Spec == Init /\ [][Next]_toggle


=============================================================================
\* Modification History
\* Last modified Wed Mar 18 12:46:23 CET 2026 by emmanueldcosta
\* Created Wed Mar 18 12:35:02 CET 2026 by emmanueldcosta
