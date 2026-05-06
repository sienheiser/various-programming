--------------------------- MODULE UserRoleSystem ---------------------------
CONSTANTS Users, Roles, Admin, Root

ASSUME Admin \in Users
ASSUME Root \in Roles

VARIABLE assigned

TypeInvariant ==
  assigned \subseteq Users \X Roles

Init ==
  assigned = {<<Admin, Root>>}

Grant(u, r) ==
  /\ u \in Users
  /\ r \in Roles
  /\ <<u, r>> \notin assigned
  /\ assigned' = assigned \cup {<<u, r>>}

Revoke(u, r) ==
  /\ <<u, r>> \in assigned
  /\ ~ (u = Admin /\ r = Root)
  /\ assigned' = assigned \ {<<u, r>>}

Next ==
  \/ \E u \in Users, r \in Roles : Grant(u, r)
  \/ \E u \in Users, r \in Roles : Revoke(u, r)
  \/ UNCHANGED assigned

Safety ==
  <<Admin, Root>> \in assigned

Spec ==
  Init /\ [][Next]_assigned

=============================================================================
\* Modification History
\* Last modified Thu Mar 19 10:13:17 CET 2026 by emmanueldcosta
\* Created Thu Mar 19 08:02:26 CET 2026 by emmanueldcosta
