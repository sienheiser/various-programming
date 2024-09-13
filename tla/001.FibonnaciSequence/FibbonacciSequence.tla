------------------------- MODULE FibbonacciSequence -------------------------
EXTENDS Naturals

VARIABLES f1,f2,f3

Init == /\ f1 = 0
        /\ f2 = 1
        /\ f3 = f1 + f2

Next == /\ f1' = f2
        /\ f2' = f3
        /\ f3' = f1+f2
        /\ f3' <= 100000

=============================================================================
\* Modification History
\* Last modified Fri Sep 13 07:27:37 CEST 2024 by emmanueldcosta
\* Created Fri Sep 13 07:22:01 CEST 2024 by emmanueldcosta
