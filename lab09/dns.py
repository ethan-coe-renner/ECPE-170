#!/usr/bin/env python3

# Python DNS query client
#
# Example usage:
#   ./dns.py --type=A --name=www.pacific.edu --server=8.8.8.8
#   ./dns.py --type=AAAA --name=www.google.com --server=8.8.8.8

# Should provide equivalent results to:
#   dig www.pacific.edu A @8.8.8.8 +noedns
#   dig www.google.com AAAA @8.8.8.8 +noedns
#   (note that the +noedns option is used to disable the pseduo-OPT
#    header that dig adds. Our Python DNS client does not need
#    to produce that optional, more modern header)


from dns_tools import dns, dns_header_bitfields  # Custom module for boilerplate code

import argparse
import ctypes
import random
import socket
import struct
import sys

def main():

    # Setup configuration
    parser = argparse.ArgumentParser(description='DNS client for ECPE 170')
    parser.add_argument('--type', action='store', dest='qtype',
                        required=True, help='Query Type (A or AAAA)')
    parser.add_argument('--name', action='store', dest='qname',
                        required=True, help='Query Name')
    parser.add_argument('--server', action='store', dest='server_ip',
                        required=True, help='DNS Server IP')

    args = parser.parse_args()
    qtype = args.qtype
    qname = args.qname
    server_ip = args.server_ip
    port = 53
    server_address = (server_ip, port)

    if qtype not in ("A", "AAAA"):
        print("Error: Query Type must be 'A' (IPv4) or 'AAAA' (IPv6)")
        sys.exit()

    # Create UDP socket
    # ---------
    # STUDENT TO-DO
    # ---------

    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)


    # Generate DNS request message
    # ---------
    # STUDENT TO-DO
    # ---------

    message = bytearray()
    message += struct.pack("!H",random.randint(0,65535)) # MessageID


    flgs = dns_header_bitfields()
    flgs.qr = 0
    flgs.opcode = 0
    flgs.aa = 0
    flgs.tc = 0
    flgs.rd = 1
    flgs.ra = 0
    flgs.reserved = 0
    flgs.rcode = 0

    message += bytes(flgs)

    message += struct.pack("!H",1) # QDCount
    message += struct.pack("!H",0) # ANCount
    message += struct.pack("!H",0) # NSCount
    message += struct.pack("!H",0) # ARCount

    # Name
    names = qname.split('.')
    for i in names:
        message += struct.pack("!B", len(i))
        message += i.encode()

    message += struct.pack("!B", 0)

    # QType
    if qtype == "A":
        message += struct.pack("!H",1)
    else:
        message += struct.pack("!H",28)

    message += struct.pack("!H",1) # QClass

    print(message)


    # Send request message to server
    # (Tip: Use sendto() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------

    bytes_sent = s.sendto(message, server_address)


    # Receive message from server
    # (Tip: use recvfrom() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------

    max_bytes = 4096
    (raw_bytes, src_addr) = s.recvfrom(max_bytes)


    # Close socket
    # ---------
    # STUDENT TO-DO
    # ---------

    s.close()


    # Decode DNS message and display to screen
    dns.decode_dns(raw_bytes)


if __name__ == "__main__":
    sys.exit(main())


