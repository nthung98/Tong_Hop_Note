Iptables – The Basics

At the low level, it is the kernel itself which “decides” what to do with packets based on rules grouped in chains, or sentences. These chains define what actions should be taken when a package matches the criteria specified by them.

The first action taken by iptables will consist in deciding what to do with a packet:

    Accept it (let it go through into our network)?
    Reject it (prevent it from accessing our network)?
    Forward it (to another chain)?

Just in case you were wondering why this tool is called iptables, it’s because these chains are organized in tables, with the filter table being the most well know and the one that is used to implement packet filtering with its three default chains:

1. The INPUT chain handles packets coming into the network, which are destined for local programs.

2. The OUTPUT chain is used to analyze packets originated in the local network, which are to be sent to the outside.

3. The FORWARD chain processes the packets which should be forwarded to another destination (as in the case of a router).

For each of these chains there is a default policy, which dictates what should be done by default when packets do not match any of the rules in the chain. You can view the rules created for each chain and the default policy by running the following command:

# iptables -L

The available policies are as follows:

    ACCEPT → lets the packet through. Any packet that does not match any rules in the chain is allowed into the network.
    DROP → drops the packet quietly. Any packet that does not match any rules in the chain is prevented from entering the network.
    REJECT → rejects the packet and returns an informative message. This one in particular does not work as a default policy. Instead, it is meant to complement packet filtering rules.
Adding Rules

To add a rule to the firewall, invoke the iptables command as follows:

# iptables -A chain_name criteria -j target

where,

    -A stands for Append (append the current rule to the end of the chain).
    chain_name is either INPUT, OUTPUT, or FORWARD.
    target is the action, or policy, to apply in this case (ACCEPT, REJECT, or DROP).
    criteria is the set of conditions against which the packets are to be examined. It is composed of at least one (most likely more) of the following flags. Options inside brackets, separated by a vertical bar, are equivalent to each other. The rest represents optional switches:

[--protocol | -p] protocol: specifies the protocol involved in a rule.
[--source-port | -sport] port:[port]: defines the port (or range of ports) where the packet originated.
[--destination-port | -dport] port:[port]: defines the port (or range of ports) to which the packet is destined.
[--source | -s] address[/mask]: represents the source address or network/mask.
[--destination | -d] address[/mask]: represents the destination address or network/mask.
[--state] state (preceded by -m state): manage packets depending on whether they are part of a state connection, where state can be NEW, ESTABLISHED, RELATED, or INVALID.
[--in-interface | -i] interface: specifies the input interface of the packet.
[--out-interface | -o] interface: the output interface.
[--jump | -j] target: what to do when the packet matches the rule.  

<img src='./img/1.png.png'>   
Which Chains are Implemented in Each Table?

We have talked about tables and chains separately. Let’s go over which chains are available in each table. Implied in this discussion is a further discussion about the evaluation order of chains registered to the same hook. If three tables have PREROUTING chains, in which order are they evaluated?

The following table indicates the chains that are available within each iptables table when read from left-to-right. For instance, we can tell that the raw table has both PREROUTING and OUTPUT chains. When read from top-to-bottom, it also displays the order in which each chain is called when the associated netfilter hook is triggered.

A few things should be noted. In the representation below, the nat table has been split between DNAT operations (those that alter the destination address of a packet) and SNAT operations (those that alter the source address) in order to display their ordering more clearly. We have also include rows that represent points where routing decisions are made and where connection tracking is enabled in order to give a more holistic view of the processes taking place:
Tables↓/Chains→ 	PREROUTING 	INPUT 	FORWARD 	OUTPUT 	POSTROUTING
(routing decision) 				                    ✓ 	
raw 	                ✓ 			                ✓ 	
(connection tracking enabled) ✓ 	                ✓ 	
mangle 	                ✓ 	      ✓ 	    ✓      	✓ 	        ✓
nat (DNAT) 	            ✓ 			                ✓ 	
(routing decision)  	✓ 			                ✓ 	
filter 	                    	  ✓      	✓ 	    ✓ 	
security 		                  ✓ 	    ✓ 	    ✓ 	
nat (SNAT) 		                  ✓ 			                  ✓

As a packet triggers a netfilter hook, the associated chains will be processed as they are listed in the table above from top-to-bottom. The hooks (columns) that a packet will trigger depend on whether it is an incoming or outgoing packet, the routing decisions that are made, and whether the packet passes filtering criteria.

Certain events will cause a table’s chain to be skipped during processing. For instance, only the first packet in a connection will be evaluated against the NAT rules. Any nat decisions made for the first packet will be applied to all subsequent packets in the connection without additional evaluation. Responses to NAT'ed connections will automatically have the reverse NAT rules applied to route correctly.
Chain Traversal Order

Assuming that the server knows how to route a packet and that the firewall rules permit its transmission, the following flows represent the paths that will be traversed in different situations:

    Incoming packets destined for the local system: PREROUTING -> INPUT
    Incoming packets destined to another host: PREROUTING -> FORWARD -> POSTROUTING
    Locally generated packets: OUTPUT -> POSTROUTING

If we combine the above information with the ordering laid out in the previous table, we can see that an incoming packet destined for the local system will first be evaluated against the PREROUTING chains of the raw, mangle, and nat tables. It will then traverse the INPUT chains of the mangle, filter, security, and nat tables before finally being delivered to the local socket.