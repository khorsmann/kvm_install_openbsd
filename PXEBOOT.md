
OpenBSD PXEBOOT only variant, ISC-DHCPD Static Config:

	host pxe-client {
		hardware ethernet 52:54:00:5c:cf:44;
		fixed-address 192.168.222.230;
		filename "pxeboot";
		next-server 192.168.222.20;
	}


