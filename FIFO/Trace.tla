---- MODULE Trace ----
EXTENDS TLC, TLCExt, Sequences, Json, ChannelImpl \* Replace with name of spec to trace

ASSUME
    /\ TLCSet(1, <<>>)
    /\ TLCSet(2, <<>>)

Record ==
    /\ LET old_trace == TLCGet(1) IN
        /\ Len(old_trace) > Len(Trace) =>
            /\ TLCSet(2, Append(TLCGet(2), old_trace))
        /\ TLCSet(1, Trace)
        

Final ==
    /\ JsonSerialize("trace-" \o ToString(JavaTime) \o ".json",
         Append(TLCGet(2), TLCGet(1))
       )
==================================================================