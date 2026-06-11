# Introduction
This project tries to bridge specification to implementations. To understand the code in this project read the specification in the following order

1. Channel.tla
2. ChannelImpl.tla
3. FIFO.tla
4. FIFOImplV2.tla 

Then try reading the implementations
channel.vhdl
fifo.vhdl


At this point the project has not worked out because the initial idea was to define idea specs (Channel.tla, FIFO.tla) and then write their detailed specs (ChannelImpl.tla, FIFOImplV2.tla). For the Channel case everything worked fine. For the FIFO, since, FIFOImplV2.tla links to the Channel.tla and FIFO.tla I could not get the model to work. If I only link the ideal channel spec to the in-channel and use the ideal fifo spec the model works. If I add the ideal channel spec to the out-channel it creates a violation against the idea spec behaviour. So at the moment this project is incomplete. I would recommend to look at /various-programming/simple-fifo/ example as it is complete.
