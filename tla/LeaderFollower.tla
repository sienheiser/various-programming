--------------------------- MODULE LeaderFollower ---------------------------
EXTENDS Sequences, Naturals
VARIABLES leaderlog, followerlog
CONSTANTS Values, MaxLength

AllSequencesOfValues == Seq(Values)


TypeInvariant == /\ leaderlog \in AllSequencesOfValues
                 /\ followerlog \in AllSequencesOfValues

PrefixInvariant == followerlog = SubSeq(leaderlog, 1, Len(followerlog))

                 
Init == /\ leaderlog = << >>
        /\ followerlog = leaderlog

WriteLeader(v) == /\ Len(leaderlog) < MaxLength
                  /\ leaderlog'= Append(leaderlog,v)
                  /\ UNCHANGED followerlog

UpdateFollower == /\ Len(followerlog) < Len(leaderlog)
                  /\ followerlog' = Append(followerlog, leaderlog[Len(followerlog)+1])
                  /\ UNCHANGED leaderlog

Next == \/ \E v \in Values: WriteLeader(v)
        \/ UpdateFollower

Spec == Init /\ [][Next]_<<leaderlog,followerlog>>

=============================================================================
\* Modification History
\* Last modified Fri Mar 20 10:27:35 CET 2026 by emmanueldcosta
\* Created Fri Mar 20 09:23:00 CET 2026 by emmanueldcosta
